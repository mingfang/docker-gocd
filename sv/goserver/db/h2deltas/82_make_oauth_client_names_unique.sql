ALTER TABLE oauthclients ADD CONSTRAINT unique_oauth_client_name UNIQUE(name);

--//@UNDO

ALTER TABLE oauthclients DROP CONSTRAINT unique_oauth_client_name;