ALTER TABLE Pipelines ADD buildCauseMessage LONGVARCHAR;

--//@UNDO

ALTER TABLE Pipelines DROP column buildCauseMessage;
