
****
DECLARE
CURSOR cur is select (*) from customers;
begin
FOR rec IN cur LOOP
dbms_output.put_line(rec.customer_id || customer_Name ||  customer_Tel);
END LOOP;
  END;


***** 

CREATE OR REPLACE PROCEDURE PS_Customer_Prodcuts (v_customer_id  customer.customer_id%type) IS
CURSOR cur IS SELECT Product_name FROM Product WHERE customer_id=v_customer_id;

BEGIN
	FOR rec IN cur LOOP
		dbms_output.put_line(rec.Product_name);
	END LOOP;
    exception
      when no_data_found then
       dbms_output.put_line(No products returned or customer not found); ;
END;

******
CREATE OR REPLACE FUNCTION FN_Customer_Orders (v_customer_id  customer.customer_id%type) RETURN number IS
nbr_ord number;
BEGIN
SELECT count(*) into nbr_ord FROM orders WHERE customer_id=customer_id;
RETURN nbr_ord;
END FN_Customer_Orders;

******
CREATE TRIGGER TRIG_INS_ORDERS
before INSERT  ON Orders FOR EACH ROW
BEGIN
	IF ( :new.OrderDate >= SYSDATE ) THEN
    dbms_output.put_line("Order Date must be greater than or equal to today's date"); 
END IF ;
END;