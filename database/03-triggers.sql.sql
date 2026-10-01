DDL
"
  CREATE OR REPLACE EDITIONABLE TRIGGER ""WKSP_FIRSTRY"".""OEHR_PRODUCT_DELETE_CHECK"" 
BEFORE DELETE ON OEHR_PRODUCT_INFORMATION
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   OEHR_ORDER_ITEMS
    WHERE  PRODUCT_ID = :OLD.PRODUCT_ID;

    IF v_count > 0 THEN
        raise_application_error(
            -20001,
            'Cannot delete product ""' || :OLD.PRODUCT_NAME || 
            '"". It is referenced by ' || v_count || 
            ' order item(s). Please delete the related order items first.'
        );
    END IF;
END;
ALTER TRIGGER ""WKSP_FIRSTRY"".""OEHR_PRODUCT_DELETE_CHECK"" ENABLE"
