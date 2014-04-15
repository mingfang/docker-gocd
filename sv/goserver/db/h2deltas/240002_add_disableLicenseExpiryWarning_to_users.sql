ALTER TABLE users ADD disableLicenseExpiryWarning boolean NOT NULL DEFAULT FALSE;

--//@UNDO

ALTER TABLE users DROP COLUMN disableLicenseExpiryWarning;
