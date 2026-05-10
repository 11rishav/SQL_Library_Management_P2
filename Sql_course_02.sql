select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from return_status;
select * from members;
 
-- Project Task

-- 1) Create a new book record  "(978-1-60129-456-2', 'To kill a Mockingbird', 'classsic', 
-- 6.00,'yes','Haper Lee','J.B.Lippincott & Co.')"

Insert Into books(isbn, book_title, category, rental_price,status,author,publisher)
values
('978-1-60129-456-2', 'To kill a Mockingbird', 'classsic', 
6.00,'yes','Haper Lee','J.B.Lippincott & Co.');
select * from books;

-- 2) update an Existing Member's Address
update members
set member_address = '125 Main St'
where member_id = 'C101';
SELECT * FROM MEMBERS;

-- 3) Delete a record from the Issued status Table
-- objective : Delete the record with Issued_id = 'IS121' from the issued_status table.

select * from issued_status;

 delete from issued_status
 where issued_id ='IS121'

-- 4) Retrieve All Books Issued by a specific Employee
--  objective : Select all books issued by the employee with emp_id = 'E101'

select * from issued_status
where issued_emp_id ='E101';

-- 5) List Numbers who have Issued More Than one Book
-- Objective : Use Group by to find members who have issued more than one book.

select 
issued_emp_id,
count(issued_id) as total_book_issued
from issued_status
group by issued_emp_id
Having count(issued_id) > 1

-- CTAS
-- 6) Create Summary Tables: Used CTAS to generate new tables based on query results -
-- each book and total book_issued_cnt

create table book_cnts
as
select 
b.isbn,
b.book_title,
count(ist.issued_id) as no_issued
from books as b
join 
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1,2 ;

select * from
book_cnts;

-- 7) Retrieve all books in a specific category:
select * from books
where category ='Classic'

-- 8 Find Total rental Income by Category:
select 
b category,
sum(b.rental_price),
count(*)
from books as b
join
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1

-- 9) List Members who registered in the last 100 days:

select * from members
where reg_date >= current_date - interval '180 days'

Insert Into members(member_id, member_name, member_address, reg_date)
values
('C118', 'sam', '145 Main St', '2024-06-01'),
('C119', 'john', '123 Main St', '2024-05-01');

-- 10) List Employees with their Branch Manager's Name and their branch detail:
select 
e1.*,
b.manager_id,
e2.emp_name as manager
from employees as e1
join
branch as b
on b.branch_id = e1.branch_id
join
employees as e2
on b.manager_id = e2.emp_id

-- 11) Create a Table of Books with rental price Above a certain Threshold 10 USD:

create table books_price_greater_than_seven
as
select * from books
where rental_price > 7;

select * from books_price_greater_than_seven

-- 12) Retrieve the list of books not yet returned
select 
distinct ist.issued_book_name
from issued_status as ist
left join
return_status as rs
on ist.issued_id = rs.issued_id
where rs.return_id is null

select * from return_status



















