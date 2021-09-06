/**
 * Created by Programming on 06.09.2021.
 */

public with sharing class TodoTriggerHandler {

    private static Boolean isFirstRun = true;
    private TodoTriggerHelper helper;

    public TodoTriggerHandler(){
        helper = new TodoTriggerHelper(Trigger.new, Trigger.old);
    }


    public void onBeforeInsert() {
        if(isFirstRun){
            isFirstRun = false;
            helper.assignTodoOnQueue();
        }
    }

    public void onAfterInsert() {
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }

    public void onBeforeUpdate() {
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }

    public void onAfterUpdate() {
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }

    public void onBeforeDelete() {
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }

    public void onAfterDelete() {
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }

    public void onUndelete() {
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }


}