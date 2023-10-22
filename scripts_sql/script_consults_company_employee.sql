-- Acessando database
use company_cycle_employee;

select Essn, Pno, Hours, Pname, Plocation from works_on, project where Pnumber = Pno;

select
	d.Dname as Departamento,
    p.Pname as Projeto,
    e.Fname as funcionario,
    dp.Dlocation as Localizacao,
    d.Mgr_ssn as Gerente    
from departament d 
join dept_locations dp on dp.Dnumber = d.Dnumber
join Project p on p.Dnum = d.Dnumber
join employee e on e.Dno = d.Dnumber;



-- Tabela Funcionários
select * from employee;

-- Tabela dependentes
select * from dependent;

-- Tabela horas trabalhadas
select * from works_on;

-- Tabela projetos
select * from project;

-- Tabela departamento
select * from departament;

-- Tabela localização do departamento
select * from dept_locations;

-- Criando view dos funcionarios por projeto e horas trabalhadas
create view works_employee as 
select
	Ssn as Seguro_social,
    concat(Fname,' ', Minit, '. ', Lname) as Funcionario,
    Pname as Projeto,
	Hours as Horas_trabalhadas
    from works_on, employee, project
    where Essn = Ssn and Pnumber = Pno;

-- Consulta view works_employee    
select * from works_employee;

-- Dados dos funcionarios
create view employee_data as
select 
	Ssn as Seguro_social,
    concat(Fname,' ',Minit, '. ', Lname) as Funcionario,
	Sex as Sexo,
    (timestampdiff(year, Bdate, current_date())) as Idade, 
    Salary as Salario,
	SUBSTRING_INDEX(SUBSTRING_INDEX(Address, '-', 1), '-', -1) AS Ed_numero,
	If(  length(Address) - length(replace(Address, '-', ''))>1,  
	SUBSTRING_INDEX(SUBSTRING_INDEX(Address, '-', 2), '-', -1) ,NULL) as Ed_rua,
	SUBSTRING_INDEX(SUBSTRING_INDEX(Address, '-', 3), '-', -1) AS Ed_cidade,
	SUBSTRING_INDEX(SUBSTRING_INDEX(Address, '-', 4), '-', -1) AS Ed_estado
from employee;

-- Consulta view employee_data
select * from employee_data;

-- Funcionarios com dependentes
create view employee_dependent as
 select
	Essn as Seguro_social,
	concat(Fname, ' ', Minit,' ', Lname) as Funcionario,
	Dependent_name as Dependente,
	Relationship as Parentesco,
	(timestampdiff(year, d.Bdate, current_date())) as Dependente_idade 
 from employee, dependent d
 where Essn = Ssn;
 
 -- Consulta view employee_dependent
 select * from employee_dependent;