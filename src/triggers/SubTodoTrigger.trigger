/**
 * Created by Слава on 09.09.2021.
 */

trigger SubTodoTrigger on Sub_Todo__c (
        before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {

    if (Trigger.isBefore && Trigger.isInsert) {
        SubTodoTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        SubTodoTriggerHandler.handleBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.isBefore && Trigger.isDelete) {
        SubTodoTriggerHandler.handleBeforeDelete(Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isInsert) {
        SubTodoTriggerHandler.handleAfterInsert(Trigger.new, Trigger.newMap);
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        SubTodoTriggerHandler.handleAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isDelete) {
        SubTodoTriggerHandler.handleAfterDelete(Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isUndelete) {
        SubTodoTriggerHandler.handleAfterUndelete(Trigger.new, Trigger.newMap);
    }
}