/**
 * Created by Programming on 10.09.2021.
 */

public with sharing class TodoCleanerBatch implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext bc){
        Decimal months = [SELECT Count_of_months__c FROM Batch_Settings__mdt WHERE DeveloperName='Delete_todos' LIMIT 1].get(0).Count_of_months__c;
        Date compareDate = System.today().addMonths(-3);
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