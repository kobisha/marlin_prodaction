﻿CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "AccessProfiles" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "ProfileID" text NULL,
    "ProfileName" text NULL,
    CONSTRAINT "PK_AccessProfiles" PRIMARY KEY (id)
);

CREATE TABLE "AccessSettings" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "ProfileID" text NULL,
    "AccessObject" text NULL,
    "Grant" text NULL,
    CONSTRAINT "PK_AccessSettings" PRIMARY KEY (id)
);

CREATE TABLE "Accounts" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "LegalCode" text NULL,
    "Name" text NULL,
    "Description" text NULL,
    "Address" text NULL,
    "Phone" text NULL,
    "Email" text NULL,
    "Supplier" boolean NOT NULL,
    "Buyer" boolean NOT NULL,
    CONSTRAINT "PK_Accounts" PRIMARY KEY (id)
);

CREATE TABLE "AccountSettings" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "BuyerWS" text NULL,
    "SupplierWS" text NULL,
    "BillingSettings" text NULL,
    CONSTRAINT "PK_AccountSettings" PRIMARY KEY (id)
);

CREATE TABLE "Barcodes" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountId" text NULL,
    "ProductID" text NULL,
    "Barcode" text NULL,
    CONSTRAINT "PK_Barcodes" PRIMARY KEY ("Id")
);

CREATE TABLE "Catalogues" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "ProductID" text NOT NULL,
    "SourceCode" text NULL,
    "Name" text NULL,
    "Description" text NULL,
    "Unit" text NULL,
    "Status" text NULL,
    "LastChangeDate" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_Catalogues" PRIMARY KEY ("Id")
);

CREATE TABLE "ConnectionSettings" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "ConnectedAccountID" text NULL,
    "AsBuyer" boolean NOT NULL,
    "AsSupplier" boolean NOT NULL,
    "PriceTypes" text NULL,
    "ConnectionStatus" text NULL,
    CONSTRAINT "PK_ConnectionSettings" PRIMARY KEY (id)
);

CREATE TABLE "ErrorCodes" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "Code" text NULL,
    "Description" text NULL,
    CONSTRAINT "PK_ErrorCodes" PRIMARY KEY (id)
);

CREATE TABLE "ExchangeLog" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "TransactionID" text NULL,
    "Date" timestamp with time zone NOT NULL,
    "MessageID" text NULL,
    "Status" text NULL,
    "ErrorCode" text NULL,
    CONSTRAINT "PK_ExchangeLog" PRIMARY KEY (id)
);

CREATE TABLE "InvoiceHeaders" (
    "InvoiceID" text NOT NULL,
    "ID" integer NOT NULL,
    "OrderID" text NOT NULL,
    "Date" timestamp with time zone NOT NULL,
    "Number" text NULL,
    "Amount" numeric NULL,
    "WaybillNumber" text NULL,
    "PaymentDate" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_InvoiceHeaders" PRIMARY KEY ("InvoiceID")
);

CREATE TABLE "Invoices" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "OrderID" text NULL,
    "Package" text NULL,
    "Period" timestamp with time zone NOT NULL,
    "Number" text NULL,
    "DueDate" timestamp with time zone NOT NULL,
    "Amount" numeric NOT NULL,
    "Status" text NULL,
    CONSTRAINT "PK_Invoices" PRIMARY KEY (id)
);

CREATE TABLE "Messages" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "MessageID" text NULL,
    "Date" timestamp with time zone NOT NULL,
    "SenderID" text NULL,
    "ReceiverID" text NULL,
    "Type" text NULL,
    "JSONBody" text NULL,
    CONSTRAINT "PK_Messages" PRIMARY KEY ("Id")
);

CREATE TABLE "OrderHeaders" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NOT NULL,
    "OrderID" text NOT NULL,
    "Date" timestamp with time zone NOT NULL,
    "Number" text NOT NULL,
    "SenderID" text NOT NULL,
    "ReceiverID" text NOT NULL,
    "ShopID" text NOT NULL,
    "Amount" numeric NULL,
    "StatusID" numeric NOT NULL,
    "SendStatus" integer NOT NULL,
    CONSTRAINT "PK_OrderHeaders" PRIMARY KEY ("Id")
);

CREATE TABLE "OrderStatus" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "StatusID" text NULL,
    "StatusName" text NULL,
    CONSTRAINT "PK_OrderStatus" PRIMARY KEY ("Id")
);

CREATE TABLE "OrderStatusHistory" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "OrderID" text NULL,
    "Date" timestamp with time zone NOT NULL,
    "StatusID" integer NOT NULL,
    CONSTRAINT "PK_OrderStatusHistory" PRIMARY KEY ("Id")
);

CREATE TABLE "PositionName" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "PriceTypeID" text NULL,
    "Name" text NULL,
    CONSTRAINT "PK_PositionName" PRIMARY KEY (id)
);

CREATE TABLE "PriceList" (
    "ID" integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "RetailerID" text NULL,
    "Date" timestamp with time zone NOT NULL,
    "Barcode" text NULL,
    "PriceType" text NULL,
    "Unit" text NULL,
    "Price" numeric NULL,
    "LastPrice" numeric NULL,
    CONSTRAINT "PK_PriceList" PRIMARY KEY ("ID")
);

CREATE TABLE "ProductCategories" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "CategoryID" text NULL,
    "ParentFolder" text NULL,
    "Code" text NULL,
    "Name" text NULL,
    CONSTRAINT "PK_ProductCategories" PRIMARY KEY ("Id")
);

CREATE TABLE "ProductsByCategories" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "ProductID" text NULL,
    "CategoryID" text NULL,
    CONSTRAINT "PK_ProductsByCategories" PRIMARY KEY ("Id")
);

CREATE TABLE "ProductsStocks" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "Barcode" text NULL,
    "ShopID" text NULL,
    "Quantity" numeric NULL,
    CONSTRAINT "PK_ProductsStocks" PRIMARY KEY ("Id")
);

CREATE TABLE "RetroBonusHeaders" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NOT NULL,
    "RetroBonusID" text NOT NULL,
    "DocumentNo" text NOT NULL,
    "SupplierID" text NOT NULL,
    "StartDate" timestamp with time zone NOT NULL,
    "EndDate" timestamp with time zone NULL,
    "Status" text NOT NULL,
    "Condition" text NOT NULL,
    "IsMarketing" boolean NOT NULL,
    "FundedByManufacturer" boolean NOT NULL,
    "MinimalPercent" numeric NULL,
    "PlanAmount" numeric NULL,
    "PlanPercent" numeric NULL,
    "ManufacturerPercent" numeric NULL,
    CONSTRAINT "PK_RetroBonusHeaders" PRIMARY KEY ("Id")
);

CREATE TABLE "ServiceLevels" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "Vendor" text NULL,
    "Shop" text NULL,
    "ProductCategory" text NULL,
    "OrderNumber" text NULL,
    "OrderDate" text NULL,
    "Product" text NULL,
    "OrderedQuantity" numeric NULL,
    "OrderedAmount" numeric NULL,
    "DeliveredQuantity" numeric NULL,
    "DeliveredAmount" numeric NULL,
    "SLAByQuantity" numeric NULL,
    "SLAByAmount" numeric NULL,
    "InTimeOrders" integer NOT NULL,
    CONSTRAINT "PK_ServiceLevels" PRIMARY KEY (id)
);

CREATE TABLE "Shops" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "ShopID" text NULL,
    "SourceCode" text NULL,
    "Name" text NULL,
    "Description" text NULL,
    "Address" text NULL,
    "ContactPerson" text NULL,
    "ContactNumber" text NULL,
    "Email" text NULL,
    "Region" text NULL,
    "Format" text NULL,
    "GPS" text NULL,
    CONSTRAINT "PK_Shops" PRIMARY KEY ("Id")
);

CREATE TABLE "UserPositions" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "PositionID" text NULL,
    "PositionName" text NULL,
    CONSTRAINT "PK_UserPositions" PRIMARY KEY (id)
);

CREATE TABLE "Users" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "AccountID" text NULL,
    "UserID" integer NOT NULL,
    "FirstName" text NULL,
    "LastName" text NULL,
    "ContactNumber" text NULL,
    "Email" text NULL,
    "Description" text NULL,
    "PositionInCompany" text NULL,
    "Password" text NULL,
    CONSTRAINT "PK_Users" PRIMARY KEY (id)
);

CREATE TABLE "UserSettings" (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    "UserID" text NULL,
    "ProfileID" text NULL,
    CONSTRAINT "PK_UserSettings" PRIMARY KEY (id)
);

CREATE TABLE "InvoiceDetails" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "InvoiceID" text NOT NULL,
    "Barcode" text NULL,
    "Unit" text NULL,
    "Quantity" numeric NULL,
    "Price" numeric NULL,
    "Amount" numeric NULL,
    CONSTRAINT "PK_InvoiceDetails" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_InvoiceDetails_InvoiceHeaders_InvoiceID" FOREIGN KEY ("InvoiceID") REFERENCES "InvoiceHeaders" ("InvoiceID") ON DELETE CASCADE
);

CREATE TABLE "OrderDetails" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "OrderHeaderID" text NULL,
    "Barcode" text NULL,
    "Unit" text NULL,
    "Quantity" numeric NULL,
    "Price" numeric NULL,
    "Amount" numeric NULL,
    "ReservedQuantity" numeric NULL,
    "OrderHeadersId" integer NULL,
    CONSTRAINT "PK_OrderDetails" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_OrderDetails_OrderHeaders_OrderHeadersId" FOREIGN KEY ("OrderHeadersId") REFERENCES "OrderHeaders" ("Id")
);

CREATE TABLE "RetroBonusDetails" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "RetroBonusID" text NOT NULL,
    "Barcode" text NOT NULL,
    "MinimalPercent" numeric NULL,
    "PlanPercent" numeric NULL,
    "ManufacturerPercent" numeric NULL,
    "RetroBonusHeaderId" integer NULL,
    CONSTRAINT "PK_RetroBonusDetails" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_RetroBonusDetails_RetroBonusHeaders_RetroBonusHeaderId" FOREIGN KEY ("RetroBonusHeaderId") REFERENCES "RetroBonusHeaders" ("Id")
);

CREATE TABLE "RetroBonusPlanRanges" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "RetroBonusID" text NOT NULL,
    "RangeNo" text NULL,
    "RangeName" text NULL,
    "RangePercent" numeric NULL,
    "RetroBonusHeaderId" integer NULL,
    CONSTRAINT "PK_RetroBonusPlanRanges" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_RetroBonusPlanRanges_RetroBonusHeaders_RetroBonusHeaderId" FOREIGN KEY ("RetroBonusHeaderId") REFERENCES "RetroBonusHeaders" ("Id")
);

CREATE INDEX "IX_InvoiceDetails_InvoiceID" ON "InvoiceDetails" ("InvoiceID");

CREATE INDEX "IX_OrderDetails_OrderHeadersId" ON "OrderDetails" ("OrderHeadersId");

CREATE INDEX "IX_RetroBonusDetails_RetroBonusHeaderId" ON "RetroBonusDetails" ("RetroBonusHeaderId");

CREATE INDEX "IX_RetroBonusPlanRanges_RetroBonusHeaderId" ON "RetroBonusPlanRanges" ("RetroBonusHeaderId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20231013090659_Initial', '7.0.12');

COMMIT;

