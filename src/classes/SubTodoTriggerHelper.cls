/**
 * Created by Слава on 09.09.2021.
 */

public with sharing class SubTodoTriggerHelper {

    public static void makeCallouts(List<Sub_Todo__c> newList) {
        for (Sub_Todo__c subTodo : newList) {
            SubTodoCallouts.makePostCallout(
                    subTodo.Id,
                    subTodo.Name,
                    subTodo.Purchase__c,
                    subTodo.Comments__c,
                    subTodo.isCompleted__c);
        }
    }
}