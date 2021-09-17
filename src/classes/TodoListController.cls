public with sharing class TodoListController {

    @AuraEnabled
    public static List<Todo__c> getUncompletedToDo() {
        return [
                SELECT Name, Priority__c, Comments__c, Account__c
                FROM Todo__c
                WHERE Status__c = 'In Progress'
                ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static List<Todo__c> getCompletedToDo() {
        return [
                SELECT Name, Priority__c, Comments__c, Account__c
                FROM Todo__c
                WHERE Status__c = 'Completed'
                ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static String setRecordTypeId() {

        Map<String, Id> mapRecordType = new Map<String, Id>();
        List<String> recordTypeName = new List<String>{

        };

        for (String recType : recordTypeName) {
            mapRecordType.put(recType, Schema.SObjectType.Todo__c.getRecordTypeInfosByName()
                    .get(recType).getRecordTypeId());
        }
        System.debug('Id for record types Todo__c = ' + mapRecordType.keySet());

        return JSON.serialize(mapRecordType);
    }




}