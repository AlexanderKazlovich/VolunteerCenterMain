/**
 * Created by Programming on 10.09.2021.
 */

public with sharing class TodoCleanerBatch implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext bc){
        Batch_Settings__mdt setting = Batch_Settings__mdt.getInstance('Delete_todos');
        Date compareDate = System.today().addMonths(0 - setting.Count_of_months__c.intValue());
        return Database.getQueryLocator('SELECT Id FROM Todo__c WHERE CreatedDate <  :compareDate');
    }

    public void execute(Database.BatchableContext bc, List<Todo__c> scope){
        if (scope != null) {
            delete scope;
        }
    }

    public void finish(Database.BatchableContext bc){

    }

}