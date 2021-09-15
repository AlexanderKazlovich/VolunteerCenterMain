/**
 * Created by Слава on 10.09.2021.
 */

trigger ContactTrigger on Contact (
        before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {

    if (Trigger.isBefore && Trigger.isInsert) {
        ContactTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        ContactTriggerHandler.handleBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.isBefore && Trigger.isDelete) {
        ContactTriggerHandler.handleBeforeDelete(Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isInsert) {
        ContactTriggerHandler.handleAfterInsert(Trigger.new, Trigger.newMap);
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        ContactTriggerHandler.handleAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isDelete) {
        ContactTriggerHandler.handleAfterDelete(Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isUndelete) {
        ContactTriggerHandler.handleAfterUndelete(Trigger.new, Trigger.newMap);
    }
}