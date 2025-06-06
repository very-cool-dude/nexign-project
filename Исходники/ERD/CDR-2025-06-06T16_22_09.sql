
CREATE TABLE callers
(
  caller_id INT    NOT NULL COMMENT '(ИД)',
  msisdn    BIGINT NOT NULL COMMENT '(Номер телефона звонящего)',
  PRIMARY KEY (caller_id)
) COMMENT 'Таблица всех звонивших людей';

ALTER TABLE callers
  ADD CONSTRAINT UQ_caller_id UNIQUE (caller_id);

ALTER TABLE callers
  ADD CONSTRAINT UQ_msisdn UNIQUE (msisdn);

CREATE TABLE calls
(
  call_id        INT      NOT NULL COMMENT '(ИД)',
  call_type      INT      NOT NULL COMMENT '(Тип звонка: входящий - 1 / исходящий - 2)',
  left_msisdn    BIGINT   NOT NULL COMMENT '(Номер телефона слева в записи)',
  right_msisdn   BIGINT   NOT NULL COMMENT '(Номер телефона справа в записи)',
  start_datetime DATETIME NOT NULL COMMENT '(Дата и время начала звонка)',
  end_datetime   DATETIME NOT NULL COMMENT '(Дата и время начала звонка)',
  is_sended      BIT      NOT NULL COMMENT '(0 - Звонок не отправлен / 1 - Звонок отправлен)',
  PRIMARY KEY (call_id)
) COMMENT 'Таблица всех звонков ';

ALTER TABLE calls
  ADD CONSTRAINT UQ_call_id UNIQUE (call_id);
