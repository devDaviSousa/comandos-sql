-->CRIANDO O BANCO
create database Ecomerce;
--------------------------------------------------------------------------

--> CRIANDO TABELAS
create table Produtos(
	Codigo int,
	Nome varchar(100),
	Descricao varchar(200),
	Preco float
)

create table Pedido(
	codigo int not null,
	DataSolicitacao datetime not null,
	FlagPago bit not null,
	TotalPedido float not null,
	CodigoCliente int not null
)

create table PedidoItem(
	CodigoPedido int not null,
	CodigoProduto int not null,
	Preco float not null,
	Quantidade int not null
)

--> ALTERANDO TABELAS
alter table Clientes add DateCriacao datetime null;

alter table Pedido add constraint pk_pedido primary key(Codigo);

--uma chave estrangeira sempre vai ser uma copia de uma primary key do msm tipo e de msm quantidade

alter table PedidoItem add constraint fk_pedido foreign key (CodigoPedido) references Pedido(Codigo);

alter table Pedido add CodigoStatus int;
alter table Pedido add DescStatus varchar(90);

--------------------------------------------------------------------------
--> APAGANDO TABELAS

drop table Produtos;
--------------------------------------------------------------------------

--> INSERINDO DADOS NA TABELAS - todos fazez os comando fazem a msm coisa

insert into clientes (nome,TipoPessoa) values('ronaldo','j');
insert clientes (Codigo,Nome,TipoPessoa) values(3,'messi','j');
insert clientes values(4,'arrascaeta','j');
insert clientes values(5,'davi','j'),(6,'davi','f');
--com primary key auto incremente omitimos a chave
insert clientes values('arrascaeta','j',GETDATE());
insert clientes values('arrascaeta','j',GETDATE());

insert Produtos values(2,'Caneta','caneta azul',1.5);
insert Produtos values('Caderno','20 materias',20.0);
insert Pedido values(getdate(),0,20.0,13);

insert PedidoItem values(13,13,1.5,2);

insert PedidoItem values(2,3,20,1);

--------------------------------------------------------------------------
--> Mostrando dados da tabela
select * from Produtos;
select * from pedido;
select * from pedidoItem;

select * from clientes;
select Nome,TipoPessoa, * from Clientes;
select * from clientes where TipoPessoa = 'f';
select * from clientes where TipoPessoa = 'j' and Nome= 'davi';
select * from clientes where TipoPessoa = 'j' or Nome= 'davi';



select * isnull(DataCriacao, getdate()), * from cliente;

select *,convert(varchar,DataSolicitacao,103)
from Pedido;

select *,
case 
when TipoPessoa = 'j' then 'juridica'
when TipoPessoa ='f' then 'fisica'
else 'pessoa indefinida'
from cliente;


--> Alterando Registro da tabela

select * from Clientes where TipoPessoa = 'f' 

update Clientes set Codigo=7,Nome='olouco' where TipoPessoa='f';
update Clientes set Codigo=1				where Codigo in(10);							
update Clientes set Codigo=7,Nome='olouco' ;


--------------------------------------------------------------------------

--> Deletar Registros
select * from PedidoItem;

delete from Clientes where Codigo in(2);

delete from Clientes;
delete from Pedido where codigo=1;
delete from PedidoItem;
delete from Produtos;


--------------------------------------------------------------------------

--junção de tabela
select * from Clientes cli
inner join Pedido ped
on cli.codigo = ped.CodigoCliente;

select * from Clientes cli
left join Pedido ped
on cli.codigo = ped.CodigoCliente;

select cli.Nome,
		ped.TotalPedido,
		case
		when cli.TipoPessoa = 'F' then 'Fisica'
		else 'Juridica'
		end TipoPessoa
		from Clientes cli
		left join Pedido ped
		on cli.Codigo = ped.CodigoCliente



select * from Clientes cli
right join Pedido ped
on cli.codigo = ped.CodigoCliente;



select from PedidoItem tl
inner join PedidoItemLog t2
on tl.CodigoPedido = t2.CodigoPedido
and tl.CodigoProduto = t2.CodigoProduto
inner join StatusPedidoItem t3
on t3.codigo = t2.CodigoStatusPedidoItem
where Preco between 1 and 2



--JOIN

select * from funcionarios
join departamentos
on departamentos.id_dept = funcionarios.id_departamento

select * from funcionarios
join departamentos
on funcionarios.id_funcionario = departamentos.id_dept
where funcionarios.id_departamento= 2;

--ALIAS
select funcionarios.nome,funcionarios.cpf ,departamentos.descricao from funcionarios
join departamentos
on funcionarios.id_funcionario = departamentos.id_dept

select func.nome as "Nome" ,func.cpf as "CPF", dept.descricao as "DEPATARMENTO"
from funcionarios as func
join departamentos as dept
on func.id_departamento = dept.id_dept

--LEFT OUTER
select * from funcionarios
left outer join departamentos
on funcionarios.id_departamento = departamentos.id_dept

--ORDER BY
select * from departamentos
order by descricao 

-- OFFSET
select * from departamentos limit 4 offset 4

--COUNT
select count(id_departamento) from funcionarios

--GROUP BY
select id_departamento, count(id_departamento)
from funcionarios
group by id_departamento



select departamentos.descricao, count(funcionarios.id_departamento)
from funcionarios
join departamentos
on funcionarios.id_departamento = departamentos.id_dept
group by departamentos.id_dept

--HAVING
select departamentos.descricao, count(funcionarios.id_departamento)
from funcionarios
join departamentos
on funcionarios.id_departamento = departamentos.id_dept
group by departamentos.id_dept
having count(funcionarios.id_funcionario)