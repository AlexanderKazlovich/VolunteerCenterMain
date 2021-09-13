/**
 * Created by Слава on 09.09.2021.
 */

public class SubTodoTriggerHelper {

    public static void makeCallouts(List<Sub_Todo__c> newList) {
        for (Sub_Todo__c subTodo : newList) {
            SubTodoCallouts.makePostCallout(
                    subTodo.Id,
                    subTodo.Name,
                    subTodo.Purchase__c,
                    subTodo.Comments__c,
                    subTodo.isCompleted__c,
                    subTodo.Todo__c,
                    subTodo.Sub_Todo__c);
        }
    }

    public static void deleteCallouts(List<Sub_Todo__c> oldList) {
        for (Sub_Todo__c subTodo : oldList) {
            SubTodoCallouts.makeDeleteCallout(
                    subTodo.Id,
                    subTodo.External_Id__c);
        }
    }

    public static void putCallouts(List<Sub_Todo__c> newList) {
        for (Sub_Todo__c subTodo : newList) {
            SubTodoCallouts.makePutCallout(
                    subTodo.Id,
                    subTodo.External_Id__c,
                    subTodo.Name,
                    subTodo.Purchase__c,
                    subTodo.Comments__c,
                    subTodo.isCompleted__c,
                    subTodo.Todo__c,
                    subTodo.Sub_Todo__c);
        }
    }
}