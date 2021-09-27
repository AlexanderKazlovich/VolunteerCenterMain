public class TodoListController {

    @AuraEnabled
    public static List<Todo__c> getUncompletedToDo() {
        return [
                SELECT Name, Priority__c, Comments__c, Account__c, Status__c,
                (SELECT Id, Name, Purchase__c, Comments__c, isCompleted__c FROM Sub_Todos__r)
                FROM Todo__c
                WHERE Status__c = 'In Progress' AND OwnerId = :UserInfo.getUserId()
                ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static List<Todo__c> getCompletedToDo() {
        return [
                SELECT Name, Priority__c, Comments__c, Account__c, Status__c,
                (SELECT Id, Name, Purchase__c, Comments__c, isCompleted__c FROM Sub_Todos__r)
                FROM Todo__c
                WHERE Status__c = 'Completed' AND OwnerId = :UserInfo.getUserId()
                ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static List<Todo__c> getNewToDo() {
        return [
                SELECT Name, Priority__c, Comments__c, Account__c, Status__c,
                (SELECT Id, Name, Purchase__c, Comments__c, isCompleted__c FROM Sub_Todos__r)
                FROM Todo__c
                WHERE Status__c = 'New' AND OwnerId = :UserInfo.getUserId()
                ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static List<Sub_Todo__c> getCompletedSubToDo() {
        return [SELECT Name, Comments__c, Purchase__c FROM Sub_Todo__c WHERE isCompleted__c = TRUE];
    }

    @AuraEnabled
    public static String setRecordTypeId() {

        Map<String, Id> mapRecordType = new Map<String, Id>();
        List<String> recordTypeName = new List<String>{
                'Emergency Assistance',
                'Finding People',
                'Nursing Home',
                'Orphans Home',
                'Physical Help',
                'Working with animals'
        };

        for (String recType : recordTypeName) {
            mapRecordType.put(recType, Schema.SObjectType.Todo__c.getRecordTypeInfosByName()
                    .get(recType).getRecordTypeId());
        }
        System.debug('Id for record types Todo__c = ' + mapRecordType.keySet());
        System.debug(mapRecordType);
        return JSON.serialize(mapRecordType);
    }

    @AuraEnabled(Cacheable=true)
    public static List<SObject> search(String searchTerm, String myObject, String filter) {
        String myQuery = null;
        Id companyRecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName='Company'].get(0).Id;
        if(filter != null && filter != ''){
            myQuery = 'Select Id, Name from '+myObject+' Where Name Like  \'%' + searchTerm + '%\' AND '+filter+' AND RecordtypeId = :companyRecordTypeId ';
        }
        else {
            if(searchTerm == null || searchTerm == ''){
                myQuery = 'Select Id, Name from '+myObject+' Where LastViewedDate != NULL '+' AND RecordtypeId = :companyRecordTypeId '+ 'ORDER BY LastViewedDate DESC ';
            }
            else {
                myQuery = 'Select Id, Name from '+myObject+' Where Name Like  \'%' + searchTerm + '%\'' +' AND RecordtypeId = :companyRecordTypeId ';
            }
        }
        List<SObject> lookUpList = Database.query(myQuery);
        return lookUpList;
    }


}