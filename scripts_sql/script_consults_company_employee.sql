-- Acessando database
use company_cycle_employee;

-- Tabela Funcionários
select * from employee;

-- Tabela departamento
select * from departament;

-- Tabela localização do departamento
select * from dept_locations;

-- Tabela projetos
select * from project;

-- Tabela horas trabalhadas
select * from works_on;

-- Tabela dependentes
select * from dependent;

-- Consulta dados dos funcionarios e seus gerentes
select
    concat(e.Fname, ' ', e.Minit, ' ', e.Lname) as Funcionarios,
	e.Ssn as Funcionarios_Ssn,
    (timestampdiff(year, e.Bdate, current_date())) as Gerentes,
    e.Address as Funcionarios_endereco,
    e.Sex as Funcionarios_Sexo,
    e.Salary as Funcionarios_Salario,
    concat(m.Fname, ' ', m.Minit, ' ', m.Lname) as Gerentes,
    d.Dname as Departamentos
from employee e
inner join departament d on e.Dno = d.Dnumber
left join employee m on e.Super_ssn = m.Ssn; 

-- Consulta projtos e localização
select 
	Essn, Pno, Hours, Pname, Plocation 
from works_on, project 
where Pnumber = Pno;

-- Consulta projetos, funcionarios, departamento e projetos
select 
    concat(f.Fname, ' ', f.Minit, '. ', f.Lname) AS Gerentes,
    concat(g.Fname, ' ', g.Minit, '. ', g.Lname) AS Funcionarios,
    d.Dname AS Departamento,
    p.Pname as Projeto
from employee f
inner join employee g ON f.Ssn = g.Super_ssn
inner join departament d ON d.Mgr_ssn = f.Ssn
inner join project p on p.Dnum = f.Dno;

-- Consulta gerentes
select 
	concat(e.Fname,' ',e.Minit,'. ',e.Lname) as Gerentes
from employee e
inner join departament d on e.Ssn = d.Mgr_ssn;

-- Consulta funcionarios por projeto e horas trabalhadas
select
	Ssn as Seguro_social,
    concat(Fname,' ', Minit, '. ', Lname) as Funcionario,
    Pname as Projeto,
	Hours as Horas_trabalhadas
from works_on, employee, project
where Essn = Ssn and Pnumber = Pno;

-- Consulta dados dos funcionários
select 
	Ssn as Seguro_social,
    concat(Fname,' ',Minit, '. ', Lname) as Funcionario,
	Sex as Sexo,
    (timestampdiff(year, Bdate, current_date())) as Idade, 
    Salary as Salario,
	substring_index(substring_index(Address, '-', 1), '-', -1) as Ed_numero,
	If(  length(Address) - length(replace(Address, '-', ''))>1,  
	substring_index(substring_index(Address, '-', 2), '-', -1) ,NULL) as Ed_rua,
	substring_index(substring_index(Address, '-', 3), '-', -1) as Ed_cidade,
	substring_index(substring_index(Address, '-', 4), '-', -1) as Ed_estado
from employee;

-- Consulta funcionarios com dependentes
 select
	Essn as Seguro_social,
	concat(Fname, ' ', Minit,' ', Lname) as Funcionario,
	Dependent_name as Dependente,
	Relationship as Parentesco,
	(timestampdiff(year, d.Bdate, current_date())) as Dependente_idade 
 from employee, dependent d
 where Essn = Ssn;