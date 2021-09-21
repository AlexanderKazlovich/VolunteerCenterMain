/**
 * Created by Слава on 10.09.2021.
 */

public with sharing class ContactTriggerHandler {

    public static Boolean isDisabledForCallouts = false;

    public static void handleBeforeInsert(List<Contact> newList) {
        // EXECUTE BEFORE INSERT LOGIC
    }

    public static void handleBeforeUpdate(List<Contact> oldList, List<Contact> newList, Map<Id, Contact> newMap, Map<Id, Contact> oldMap) {
        // BEFORE UPDATE LOGIC
    }


    public static void handleBeforeDelete(List<Contact> oldList, Map<Id, Contact> oldMap) {
        // BEFORE DELETE LOGIC
    }

    public static void handleAfterInsert(List<Contact> newList, Map<Id, Contact> newMap) {
        if (!isDisabledForCallouts) {
            ContactTriggerHelper.makeCallouts(newList);
            // EXECUTE AFTER INSERT LOGIC
        }
    }

    public static void handleAfterUpdate(List<Contact> oldList, List<Contact> newList, Map<Id, Contact> newMap, Map<Id, Contact> oldMap) {
        if (!isDisabledForCallouts) {
            ContactTriggerHelper.putCallouts(newList);
            // AFTER UPDATE LOGIC
        }
    }

    public static void handleAfterDelete(List<Contact> oldList, Map<Id, Contact> oldMap) {
        if (!isDisabledForCallouts) {
            ContactTriggerHelper.deleteCallouts(oldList);
            // AFTER DELETE LOGIC
        }
    }

    public static void handleAfterUndelete(List<Contact> newList, Map<Id, Contact> newMap) {
        // AFTER UNDELETE LOGIC
    }
}