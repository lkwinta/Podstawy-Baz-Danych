-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-11-28 14:27:30.295

-- tables
-- Table: BucketProducts
CREATE TABLE BucketProducts (
                                bucket_entry_id int  NOT NULL,
                                user_id int  NOT NULL,
                                product_id int  NOT NULL,
                                CONSTRAINT BucketProducts_pk PRIMARY KEY  (bucket_entry_id)
);

-- Table: Clients
CREATE TABLE Clients (
                         user_id int  NOT NULL,
                         first_name nvarchar  NOT NULL,
                         last_name nvarchar  NOT NULL,
                         postal_code int  NOT NULL,
                         city nvarchar  NOT NULL,
                         street_address nvarchar  NOT NULL,
                         CONSTRAINT user_id PRIMARY KEY  (user_id)
);

-- Table: MeetingType
CREATE TABLE MeetingType (
                             type_id int  NOT NULL,
                             type_name nvarchar  NOT NULL,
                             CONSTRAINT type_id PRIMARY KEY  (type_id)
);

-- Table: ProductType
CREATE TABLE ProductType (
                             product_id int  NOT NULL,
                             product_name nvarchar  NOT NULL,
                             CONSTRAINT ProductType_pk PRIMARY KEY  (product_id)
);

-- Table: Studies
CREATE TABLE Studies (
                         studies_id int  NOT NULL,
                         name nvarchar  NOT NULL,
                         CONSTRAINT studies_id PRIMARY KEY  (studies_id)
);

-- Table: StudiesMeetings
CREATE TABLE StudiesMeetings (
                                 meeting_id int  NOT NULL,
                                 studies_id int  NOT NULL,
                                 date date  NOT NULL,
                                 type_id int  NOT NULL,
                                 CONSTRAINT meeting_id PRIMARY KEY  (meeting_id)
);

-- Table: StudiesParticipants
CREATE TABLE StudiesParticipants (
                                     participant_id int  NOT NULL,
                                     studies_id int  NOT NULL,
                                     user_id int  NOT NULL,
                                     is_advance_payment bit  NOT NULL,
                                     is_full_payment bit  NOT NULL,
                                     CONSTRAINT participant_id PRIMARY KEY  (participant_id)
);

-- foreign keys
-- Reference: BucketItems_Clients (table: BucketProducts)
ALTER TABLE BucketProducts ADD CONSTRAINT BucketItems_Clients
    FOREIGN KEY (user_id)
        REFERENCES Clients (user_id);

-- Reference: BucketItems_ProductType (table: BucketProducts)
ALTER TABLE BucketProducts ADD CONSTRAINT BucketItems_ProductType
    FOREIGN KEY (product_id)
        REFERENCES ProductType (product_id);

-- Reference: StudiesMeetings_MeetingType (table: StudiesMeetings)
ALTER TABLE StudiesMeetings ADD CONSTRAINT StudiesMeetings_MeetingType
    FOREIGN KEY (type_id)
        REFERENCES MeetingType (type_id);

-- Reference: StudiesMeetings_Studies (table: StudiesMeetings)
ALTER TABLE StudiesMeetings ADD CONSTRAINT StudiesMeetings_Studies
    FOREIGN KEY (studies_id)
        REFERENCES Studies (studies_id);

-- Reference: StudiesParticipants_Clients (table: StudiesParticipants)
ALTER TABLE StudiesParticipants ADD CONSTRAINT StudiesParticipants_Clients
    FOREIGN KEY (user_id)
        REFERENCES Clients (user_id);

-- Reference: StudiesParticipants_Studies (table: StudiesParticipants)
ALTER TABLE StudiesParticipants ADD CONSTRAINT StudiesParticipants_Studies
    FOREIGN KEY (studies_id)
        REFERENCES Studies (studies_id);

-- End of file.

