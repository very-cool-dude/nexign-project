
CREATE TABLE user_types
(
  user_type_id   INT         NOT NULL COMMENT '(ИД)',
  user_type_name VARCHAR(30) NOT NULL COMMENT '(Название типа пользователя: Менеджер)',
  PRIMARY KEY (user_type_id)
) COMMENT 'Таблица типов пользователей';

ALTER TABLE user_types
  ADD CONSTRAINT UQ_user_type_id UNIQUE (user_type_id);

CREATE TABLE users
(
  user_id      INT         NOT NULL COMMENT '(ИД)',
  user_type_id INT         NOT NULL COMMENT '(ИД типа пользователя)',
  login        VARCHAR(30) NOT NULL COMMENT '(Логин пользователя)',
  password     VARCHAR(30) NULL     COMMENT '(Пароль пользователя)',
  PRIMARY KEY (user_id)
) COMMENT 'Таблица пользователей';

ALTER TABLE users
  ADD CONSTRAINT UQ_user_id UNIQUE (user_id);

ALTER TABLE users
  ADD CONSTRAINT UQ_login UNIQUE (login);

ALTER TABLE users
  ADD CONSTRAINT FK_user_types_TO_users
    FOREIGN KEY (user_type_id)
    REFERENCES user_types (user_type_id);
