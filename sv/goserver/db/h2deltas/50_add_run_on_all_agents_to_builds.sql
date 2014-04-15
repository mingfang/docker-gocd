alter table builds add column runOnAllAgents boolean default false;

--//@UNDO

alter table builds drop column runOnAllAgents;