set sql_mode ='NO_AUTO_VALUE_ON_ZERO';

create table User
(
    id       varchar(20)  not null
        primary key,
    name     varchar(100) null,
    password varchar(40)  not null,
    mail     varchar(100) null
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create table class
(
    id   int auto_increment
        primary key,
    name varchar(100) null
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create table auth
(
    UserId    varchar(20) null,
    classId   int         null,
    privilege int         null,
    constraint auth_ibfk_1
        foreign key (UserId) references User (id)
            on delete cascade,
    constraint auth_ibfk_2
        foreign key (classId) references class (id)
            on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create index UserId
    on auth (UserId);

create index classId
    on auth (classId);

create table contest
(
    id          int auto_increment
        primary key,
    classId     int                  null,
    startTime   mediumtext           null,
    endTime     mediumtext           null,
    title       varchar(100)         null,
    description text                 null,
    creatorId   varchar(20)          null,
    access      tinyint(1) default 0 null,
    constraint contest_ibfk_1
        foreign key (classId) references class (id)
            on delete cascade,
    constraint contest_ibfk_2
        foreign key (creatorId) references User (id)
            on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create index classId
    on contest (classId);

create index creatorId
    on contest (creatorId);

create table post
(
    postId     int auto_increment
        primary key,
    groupId    int         null,
    userId     varchar(20) null,
    title      text        null,
    content    text        null,
    modifyTime mediumtext  null,
    goPublic   tinyint(1)  null,
    goMail     tinyint(1)  null,
    constraint post_ibfk_1
        foreign key (groupId) references class (id)
            on update cascade on delete cascade,
    constraint post_ibfk_2
        foreign key (userId) references User (id)
            on update cascade on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create table comment
(
    commentId  int auto_increment
        primary key,
    postId     int         null,
    floorId    int         null,
    userId     varchar(20) null,
    comment    text        null,
    modifyTime mediumtext  null,
    constraint comment_ibfk_1
        foreign key (postId) references post (postId)
            on update cascade on delete cascade,
    constraint comment_ibfk_2
        foreign key (userId) references User (id)
            on update cascade on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create index postId
    on comment (postId);

create index userId
    on comment (userId);

create index groupId
    on post (groupId);

create index userId
    on post (userId);

create table problem
(
    problemId       int auto_increment
        primary key,
    shownId         text                       null,
    title           text                       null,
    contestId       int                        null,
    description     text                       null,
    inputFormat     text                       null,
    outputFormat    text                       null,
    tips            text                       null,
    timeLimit       mediumtext                 null,
    spaceLimit      mediumtext                 null,
    testCaseId      varchar(100)               null,
    testCase        text                       null,
    allowedLanguage varchar(100)               null,
    creatorId       varchar(20)                null,
    totalScore      int          default 0     null,
    allowPartial    tinyint(1)   default 1     null,
    punishRule      varchar(100) default '[1]' null,
    isPublish       tinyint(1)   default 0     null,
    constraint problem_ibfk_1
        foreign key (contestId) references contest (id)
            on delete cascade,
    constraint problem_ibfk_2
        foreign key (creatorId) references User (id)
            on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create table answer
(
    answerId   int auto_increment
        primary key,
    problemId  int        null,
    language   text       null,
    code       text       null,
    isStandard tinyint(1) null,
    constraint answer_ibfk_1
        foreign key (problemId) references problem (problemId)
            on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create index problemId
    on answer (problemId);

create index contestId
    on problem (contestId);

create index creatorId
    on problem (creatorId);

create table result
(
    resultId   varchar(100) not null
        primary key,
    submitTime mediumtext   null,
    userId     varchar(20)  null,
    problemId  int          null,
    code       text         null,
    constraint result_ibfk_1
        foreign key (problemId) references problem (problemId)
            on delete cascade,
    constraint result_ibfk_2
        foreign key (userId) references User (id)
            on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create table checkpoint
(
    checkpointId int auto_increment
        primary key,
    resultId     varchar(100) null,
    id           int          null,
    total        int          null,
    timeCost     mediumtext   null,
    memoryCost   mediumtext   null,
    correct      tinyint(1)   null,
    code         varchar(10)  null,
    name         varchar(30)  null,
    message      mediumtext   null,
    color        varchar(20)  null,
    constraint checkpoint_ibfk_1
        foreign key (resultId) references result (resultId)
            on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create index resultId
    on checkpoint (resultId);

create index problemId
    on result (problemId);

create index userId
    on result (userId);

create table samples
(
    id        int auto_increment
        primary key,
    problemId int  null,
    input     text null,
    output    text null,
    constraint samples_ibfk_1
        foreign key (problemId) references problem (problemId)
            on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create index problemId
    on samples (problemId);

create table scoreRule
(
    problemId    int                        not null
        primary key,
    totalScore   int          default 0     null,
    allowPartial tinyint(1)   default 1     null,
    punishRule   varchar(100) default '[1]' null,
    constraint scoreRule_ibfk_1
        foreign key (problemId) references problem (problemId)
            on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create table submitTemplate
(
    id        int auto_increment
        primary key,
    problemId int         null,
    language  varchar(20) null,
    code      text        null,
    constraint submitTemplate_ibfk_1
        foreign key (problemId) references problem (problemId)
            on delete cascade
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

create index problemId
    on submitTemplate (problemId);


insert into User values(1,'admin',123456,'111@111.com');
insert into class values (0,'public');
insert into auth values(1,0,1);
insert into contest values (0,0,0,0,'public','public',1,1)
