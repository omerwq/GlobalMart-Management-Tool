DDL
"
  CREATE OR REPLACE EDITIONABLE TRIGGER ""WKSP_FIRSTRY"".""OEHR_ORDER_DELETE_CHECK"" 
BEFORE DELETE ON OEHR_ORDERS
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_count
    FROM   OEHR_ORDER_ITEMS
    WHERE  ORDER_ID = :OLD.ORDER_ID;

    IF v_count > 0 THEN
        raise_application_error(
            -20002,
            'Cannot delete Order #' || :OLD.ORDER_ID || 
            '. It has ' || v_count || 
            ' item(s). Please delete the order items first.'
        );
    END IF;
END;
ALTER TRIGGER ""WKSP_FIRSTRY"".""OEHR_ORDER_DELETE_CHECK"" ENABLE"
