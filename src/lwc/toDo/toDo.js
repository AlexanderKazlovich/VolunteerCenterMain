import {LightningElement, api, track, wire} from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import TODO_RECORDTYPE from '@salesforce/schema/Todo__c';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {createRecord, deleteRecord, updateRecord} from 'lightning/uiRecordApi';
import setRecordTypeId from '@salesforce/apex/TodoListController.setRecordTypeId';
import getUncompletedToDo from '@salesforce/apex/TodoListController.getUncompletedToDo';
import getCompletedToDo from '@salesforce/apex/TodoListController.getCompletedToDo';
import getNewToDo from '@salesforce/apex/TodoListController.getNewToDo';
import TODO_OBJECT from '@salesforce/schema/Todo__c';
import TODO_ID from '@salesforce/schema/Todo__c.Id';
import TODO_DATE from '@salesforce/schema/Todo__c.DateTime__c'
import TODO_Purchase from '@salesforce/schema/Todo__c.Purchase__c';
import TODO_Comments from '@salesforce/schema/Todo__c.Comments__c';
import TODO_NAME from '@salesforce/schema/Todo__c.Name';
import TODO_STATUS from '@salesforce/schema/Todo__c.Status__c';
import TODO_PRIORITY from '@salesforce/schema/Todo__c.Priority__c';
import TODO_COMPANY from '@salesforce/schema/Todo__c.Account__c';

import SUBTODO_OBJECT from '@salesforce/schema/Sub_Todo__c';
import SUBTODO_ID from '@salesforce/schema/Sub_Todo__c.Id';
import SUBTODO_NAME from '@salesforce/schema/Sub_Todo__c.Name';
import SUBTODO_PURCHASE from '@salesforce/schema/Sub_Todo__c.Purchase__c';
import SUBTODO_COMMENTS from '@salesforce/schema/Sub_Todo__c.Comments__c';
import SUBTODO_COMPLETED from '@salesforce/schema/Sub_Todo__c.isCompleted__c';



export default class toDo extends LightningElement {

    @wire(getObjectInfo, { objectApiName: TODO_RECORDTYPE })
    propertyOrFunction;
    @track todoCompany = TODO_COMPANY;
    closedDate = TODO_DATE;
    subTodoApiName = SUBTODO_OBJECT;
    todoApiName = TODO_OBJECT;
    purchase = TODO_Purchase;
    comments = TODO_Comments;
    todoStatus = TODO_STATUS;

    //ALL VARIABLES
    @api recordId;
    //LISTS VARIABLES
    @track uncompletedToDoList;
    @track completedToDoList;
    @track newTodoList;
    //VARIABLES FOR TO DO
    toDoName;

    jsonMapRecIdRecName;
    currentRecTypeId = '0125g000000RK9tAAG';
    recordType = setRecordTypeId;
    @track statusToDO = TODO_STATUS;
    @track nameToDo = TODO_NAME;

    priorityToDo = TODO_PRIORITY;
    //complete / oncomplete
    @track status = false;
    //modal variables
    @track openModal = false;
    @track openUpdateModal = false;
    //ERROR VARIABLE
    error;
    //VARIABLE FOR SHOWING TO DO EDIT BLOCK
    @track editToDoForm = '"slds-is-expanded slds-hide slds-hidden"';

    //refresh todo list for uncompleted and completed todo
    refreshToDoList() {
        //RENDER TO DO AND SUBTODO ITEMS FOR UNCOMPLETE LIST TASK
        getUncompletedToDo()
            .then(result => {
                this.uncompletedToDoList = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.uncompletedToDoList = undefined;
            });
        //RENDER TO DO AND SUBTODO ITEMS FOR COMPLETE LIST TASK
        getCompletedToDo()
            .then(result => {
                this.completedToDoList = result;
                this.error = undefined;
            })
            .catch(error => {
                    this.error = error;
                    this.completedToDoList = undefined;
                });


        console.log('Refresh lists finished!');
    }


    //CREATING NEW TODO
    handleCreateSuccess(event){
        this.openModal = false;
        this.refreshToDoList();
        this.dispatchEvent(
            new ShowToastEvent({
                title: "SUCCESS",
                message: "Todo item has been created. Record id: " + event.detail.id,
                variant: "success"
            })
        );
    }

    //creating new subtodo

    createNewSubToDo(event){

        this.openModal = true;
        this.refreshToDoList();
        this.refreshToDoList()
        this.dispatchEvent(
            new ShowToastEvent( {
                title: "SUCCESS",
                message: "Sub-Todo item has been created. Record id: " + event.detail.id,
                variant: "success"
        })

        );
}

    //CONNECTED CALLBACK FOR APEX FUNCTION
    connectedCallback() {
        //RENDER TO DO AND SUBTODO ITEMS FOR UNCOMPLETE LIST TASK
        getUncompletedToDo()
            .then(result => {
                this.uncompletedToDoList = result;
                this.error = undefined;
                console.log(result);
            })
            .catch(error => {
                this.error = error;
                this.uncompletedToDoList = undefined;
            });
        //RENDER TO DO AND SUBTODO ITEMS FOR COMPLETE LIST TASK
        getCompletedToDo()
            .then(result => {
                this.completedToDoList = result;
                this.error = undefined;
                console.log(result);

            })
            .catch(error => {
                    this.error = error;
                    this.completedToDoList = undefined;
            });

            
        //RETURN MAP <RECORD TYPE ID, RECORD TYPE NAME>
        setRecordTypeId()
            .then(result => {
                this.jsonMapRecIdRecName = result;
                this.error = undefined;
            })
            .catch(error => {
                    this.error = error;
                    this.jsonMapRecIdRecName = undefined;
                }
            );
        console.log('Connected callback finished');
    }

//START BLOCK HANDLE CREATE SUB TO DO
   handleAddSubToDoSuccess(event) {
        this.openModal = false;
        this.refreshToDoList();
        this.dispatchEvent(
            new ShowToastEvent({
                title: "SUCCESS",
                message: "SubTodo item has been created. Record id: " + event.detail.id,
                variant: "success"
            })
        );
        this.refreshToDoList();
    }
////////////////////////////END BLOCK HANDLES CREATING SUB TO DO ///////////////////////////////////////////////////////

///////////////////////////START OPEN / CLOSE TO DO BLOCK //////////////////////////////////////////////////////////////
    closeToDo(event) {
        console.log("ID OF COMPLETED TODO = " + event.target.dataset.recordid);
        const fields = {};
        fields[TODO_STATUS.fieldApiName] = 'Completed';
        console.log("complete todo, update status");
        fields[TODO_ID.fieldApiName] = event.target.dataset.recordid;
        const recordInput = {fields};
        console.log('updateToDoStatus / recordInput = ' + recordInput);
        updateRecord(recordInput)
            .then(() => {
                console.log("!!!!Updating UncompletedToDo list after complete!!!")
                this.refreshToDoList();
                this.showToast('Success', "ToDo Completed and moved in Completed ToDo list",
                    "success");
            })
            .catch(error => {
                this.showToast('Error with completing ToDo ', error.body.message, "error")
            });
    }

    reopenToDo(event) {
        console.log("ID OF REOPEN TODO = " + event.target.dataset.recordid);
        const fields = {};
        fields[TODO_STATUS.fieldApiName] = 'In Progress';
        fields[TODO_ID.fieldApiName] = event.target.dataset.recordid;
        const recordInput = {fields};
        console.log('REOPEN TODO / recordInput = ' + recordInput);
        updateRecord(recordInput)
            .then(() => {
                console.log("!!!!Updating CompletedToDo list after reopen ToDo!!!")
                this.refreshToDoList();
                this.showToast('Success', "ToDo was successfully reopened", "success")
            })
            .catch(error => {
                this.showToast('Error with reopen todo', reduceErrors(error).join(', '), "error")});
    }
////////////////////////////END UPDATING TO DO STATUS //////////////////////////////////////////////////////////////////

///////////////////////////START DELETE TO DO SUB TO DO RECORDS//////////////////////////////////////////////////////////
    deleteToDo(event) {
        const recordToDoId = event.target.dataset.recordid;
        console.log('!!!!!!!ID DELETING TODO!!!!! = ' + recordToDoId);
        deleteRecord(recordToDoId)
            .then(() => {
                this.showToast('Success', "ToDo was successfully deleted", "success")
                this.refreshToDoList();
            })
            .catch((error) => {
                this.showToast('Error with deleting todo', reduceErrors(error).join(', '), "error")
            });
    }
    deleteSubToDo(event) {
        const recordSubToDoId = event.target.dataset.recordid;
        console.log('!!!!!!!ID DELETING SUBTODO!!!!! = ' + recordSubToDoId);
        deleteRecord(recordSubToDoId)
            .then(() => {
                this.refreshToDoList();
            })
            .catch((error) => {
                this.showToast('Error with deleting subTodo', reduceErrors(error).join(', '), "error")
            });
    }
////////////////////////END DELETE TO DO SUB TO DO BLOCK////////////////////////////////////////////////////////////////

// start edit todo block
    handleToDoEditSuccess() {
        this.refreshToDoList();
        console.log("!!!!!handleToDoEditSuccess")
    }
    submitUpdateSuccess() {
        this.dispatchEvent(
            new ShowToastEvent(
                {
                    title: 'Success',
                    message: 'ToDo is updated!',
                    variant: 'success'
                })
        );
        this.editToDoForm = '"slds-is-expanded slds-hide slds-hidden"';
        console.log("Update complete");
    }
    handleSetActiveSectionEdit() {
        this.editToDoForm = '""';
    }
    handleUpdateToDoSuccess() {
        this.refreshToDoList();
        this.dispatchEvent(
            new ShowToastEvent(
                {
                    title: 'Success',
                    message: 'ToDo is updated!',
                    variant: 'success'
                })
        );

        console.log("Update complete");
    }

///////////////////////CHANGE SUB TO DO STATUS//////////////////////////////////////////////////////////////////////////
    handleChangeUncompleteStatus(event) {
        console.log("ID OF COMPLETED SUBTODO = " + event.target.dataset.recordid);
        const fields = {};
        fields[SUBTODO_COMPLETED.fieldApiName] = false;
        fields[SUBTODO_ID.fieldApiName] = event.target.dataset.recordid;
        const recordInput = {fields};
        updateRecord(recordInput)
            .then(() => {
                console.log("!!!!Updating Uncompleted !!!SUBTODO!!! list after complete!!!")
                this.refreshToDoList();
            })
            .catch(error => {
                this.showToast('Error with completed SubToDo', reduceErrors(error).join(', '), "error")
            });
    }

    //RECORD CREATION HANDLERS
    handleChangeRecordType(event) {
        this.selectedRecordTypeId = event.detail.value;
    }

//END CREATION BLOCK

//modal windows
    showModal() {
        this.openModal = true;
    }

    closeModal() {
        this.openModal = false;
        this.openUpdateModal = false;
    }

//message function
    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent(
                {
                    title: title,
                    message: message,
                    variant: variant
                })
        );
    }

    refreshToDoList() {
        //RENDER TO DO AND SUBTODO ITEMS FOR UNCOMPLETE LIST TASK
        getUncompletedToDo()
            .then(result => {
                this.uncompletedToDoList = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.uncompletedToDoList = undefined;
            });
        //RENDER TO DO AND SUBTODO ITEMS FOR COMPLETE LIST TASK
        getCompletedToDo()
            .then(result => {
                this.completedToDoList = result;
                this.error = undefined;
            })
            .catch(error => {
                    this.error = error;
                    this.completedToDoList = undefined;
                }
            );
    }

    //Sasha recordtype
    @track selectedRecordTypeId;
    @track options;

    @wire(getObjectInfo, {objectApiName: TODO_OBJECT})
    todoObjectInfo({data, error}){
        if(data){
            let optionsValues = [];
            const recordTypeInfos = data.recordTypeInfos;
            let recordTypeValues = Object.values(recordTypeInfos);
            for(let i = 0; i < recordTypeValues.length; i++){
                if(recordTypeValues[i].name !== 'Master'){
                    optionsValues.push({
                        label : recordTypeValues[i].name,
                        value : recordTypeValues[i].recordTypeId
                    })
                }
            }
            this.options = optionsValues;
        }
    }

    // Sasha create sub todo
    @track subtodoName = SUBTODO_NAME;
    @track subtodoId = SUBTODO_ID;
    @track subtodoPurchase = SUBTODO_PURCHASE;
    @track subtodoComments = SUBTODO_COMMENTS;
    @track subtodoCompleted = SUBTODO_COMPLETED;

    @track selectedAccountId;

    @track openModalCreateSubTodo = false;
    openSubTodoModal(){
        this.openModalCreateSubTodo = true;
    }

    closeSubtodoModal(){
        this.openModalCreateSubTodo = false;
    }

    handleCreateSubtodoSuccess(event){
        this.openModalCreateSubTodo = false;
        this.dispatchEvent(
            new ShowToastEvent({
                title: "SUCCESS",
                message: "Sub Todo item has been created. Record id: " + event.detail.id,
                variant: "success"

            })

        );
        this.refreshToDoList()
    }



    //

    handleAccountSelection(event){
        this.selectedAccountId = event.detail;
        console.log("the selected record id is"+event.detail);
    }

}