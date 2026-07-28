-- Uses alter.db database.

-- To present how to add a column to a table.

-- Volontarily add a column containing a "typo" ("tipe" instead of "type")
ALTER TABLE "swipes"
ADD COLUMN "tipe" TEXT;
