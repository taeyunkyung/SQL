-- author 테이블
create table author(
    author_id     number(10),
    author_name   varchar2(100) not null,
    author_desc   varchar2(500),
    primary key(author_id)
);

-- book 테이블
create table book(
    book_id     number(10),
    title       varchar2(100) not null,
    pubs        varchar2(100),
    pub_date    date,
    author_id   number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id)
    references author(author_id)
);

-- seq_author_id 생성
create sequence seq_author_id
increment by 1
start with 1
nocache;

select * from user_sequences;

insert into author
values(seq_author_id.nextval,'이문열','경북 영양');
insert into author
values(seq_author_id.nextval,'박경리','경남 통영');
insert into author
values(seq_author_id.nextval,'유시민','17대 국회의원');
insert into author
values(seq_author_id.nextval,'주호민','네이버퉵툰');
insert into author
values(seq_author_id.nextval,'강풀','온라인 만화가 1세대');
insert into author
values(seq_author_id.nextval,'김영하','알쓸신잡');

-- seq_book_id 생성
create sequence seq_book_id
increment by 1
start with 1
nocache;

insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);
insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);
insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);
insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);
insert into book
values (seq_book_id.nextval, '신과 함께', '중앙북스(books)', '2012-02-22', 4);
insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);
insert into book
values (seq_book_id.nextval, '오직 두 사람', '문학동네', '2017-05-04', 6);
insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);

-- update
update author 
set author_desc = '서울특별시'
where author_id = 5;

-- delete
delete from author
where author_id = 4;

-- select문
select *
from book bo, author au
where bo.author_id = au.author_id;