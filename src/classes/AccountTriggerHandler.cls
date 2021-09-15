/**
 * Created by Слава on 10.09.2021.
 */

public with sharing class AccountTriggerHandler {

    public static void handleBeforeInsert(List<Account> newList) {
        // EXECUTE BEFORE INSERT LOGIC
    }

    public static void handleBeforeUpdate(List<Account> oldList, List<Account> newList, Map<Id, Account> newMap, Map<Id, Account> oldMap) {
        // BEFORE UPDATE LOGIC
    }


    public static void handleBeforeDelete(List<Account> oldList, Map<Id, Account> oldMap) {
        // BEFORE DELETE LOGIC
    }

    public static void handleAfterInsert(List<Account> newList, Map<Id, Account> newMap) {
        AccountTriggerHelper.makeCallouts(newList);
        // EXECUTE AFTER INSERT LOGIC
    }

    public static void handleAfterUpdate(List<Account> oldList, List<Account> newList, Map<Id, Account> newMap, Map<Id, Account> oldMap) {
        AccountTriggerHelper.putCallouts(newList);
        // AFTER UPDATE LOGIC
    }

    public static void handleAfterDelete(List<Account> oldList, Map<Id, Account> oldMap) {
        AccountTriggerHelper.deleteCallouts(oldList);
        // AFTER DELETE LOGIC
    }

    public static void handleAfterUndelete(List<Account> newList, Map<Id, Account> newMap) {
        // AFTER UNDELETE LOGIC
    }

}