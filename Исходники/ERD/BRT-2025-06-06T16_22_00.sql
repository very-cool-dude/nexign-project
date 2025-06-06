
CREATE TABLE call_types
(
  call_type_id   int         NOT NULL UNIQUE,
  call_type_name varchar(20) UNIQUE,
  PRIMARY KEY (call_type_id)
);

COMMENT ON TABLE call_types IS 'Таблица типов звонков';

COMMENT ON COLUMN call_types.call_type_id IS '(ИД)';

COMMENT ON COLUMN call_types.call_type_name IS '(Назание типа звонка - входящий / исходящий)';

CREATE TABLE calls
(
  call_id           int      NOT NULL UNIQUE,
  call_type_id      int      NOT NULL,
  left_msisdn       bigint   NOT NULL,
  left_operator_id  int      NOT NULL,
  right_msisdn      bigint   NOT NULL,
  right_operator_id int      NOT NULL,
  start_datetime    datetime NOT NULL,
  end_datetime      datetime NOT NULL,
  is_tarifficated   bit      NOT NULL,
  PRIMARY KEY (call_id)
);

COMMENT ON TABLE calls IS 'Таблица звонков наших абонентов';

COMMENT ON COLUMN calls.call_id IS '(ИД)';

COMMENT ON COLUMN calls.call_type_id IS '(ИД типа звонка)';

COMMENT ON COLUMN calls.left_msisdn IS '(Номер телефона слева в записи)';

COMMENT ON COLUMN calls.left_operator_id IS '(ИД оператора номера слева)';

COMMENT ON COLUMN calls.right_msisdn IS '(Номер телефона справа в записи)';

COMMENT ON COLUMN calls.right_operator_id IS '(ИД оператора номера справа)';

COMMENT ON COLUMN calls.start_datetime IS '(Дата и время начала звонка)';

COMMENT ON COLUMN calls.end_datetime IS '(Дата и время окончания звонка)';

COMMENT ON COLUMN calls.is_tarifficated IS '(0 - Звонок не тарифицирован / 1 - Звонок тарифицирован)';

CREATE TABLE client_entities
(
  client_entity_id       int  NOT NULL UNIQUE,
  client_id              int  NOT NULL,
  entity_instance_id     int  NOT NULL,
  entity_type_id         int  NOT NULL,
  priority               int  NOT NULL,
  entity_activation_date date NOT NULL,
  period_payment_date    date,
  PRIMARY KEY (client_entity_id)
);

COMMENT ON TABLE client_entities IS 'Таблица сущностей клиентов';

COMMENT ON COLUMN client_entities.client_entity_id IS '(ИД)';

COMMENT ON COLUMN client_entities.client_id IS '(ИД абонента)';

COMMENT ON COLUMN client_entities.entity_instance_id IS '(ИД сущности)';

COMMENT ON COLUMN client_entities.entity_type_id IS '(ИД типа сущности: тариф / пакет звонков / пакет минут и т.д.)';

COMMENT ON COLUMN client_entities.priority IS '(Приоритет сущности: После исчерпания лимита ресурса сущность заменяется на другую с более низким приоритетом)';

COMMENT ON COLUMN client_entities.entity_activation_date IS '(Дата активации сущности)';

COMMENT ON COLUMN client_entities.period_payment_date IS '(Дата оплаты сущности)';

CREATE TABLE clients
(
  client_id               int           NOT NULL UNIQUE,
  msisdn                  bigint        NOT NULL UNIQUE,
  last_name               varchar(30)   NOT NULL,
  first_name              varchar(30)   NOT NULL,
  middle_name             varchar(30)  ,
  operator_id             int           NOT NULL,
  registration_date       date          NOT NULL,
  head_entity_instance_id int          ,
  balance                 decimal(10,1) NOT NULL,
  balance_currency_id     int           NOT NULL,
  region_id               int           NOT NULL,
  is_sended               int           NOT NULL,
  description             varchar(50)  ,
  PRIMARY KEY (client_id)
);

COMMENT ON TABLE clients IS 'Таблица наших абонентов';

COMMENT ON COLUMN clients.client_id IS '(ИД)';

COMMENT ON COLUMN clients.msisdn IS '(Номер телефона абонента)';

COMMENT ON COLUMN clients.last_name IS '(Фамилия абонента)';

COMMENT ON COLUMN clients.first_name IS '(Имя абонента)';

COMMENT ON COLUMN clients.middle_name IS '(Отчество абонента)';

COMMENT ON COLUMN clients.operator_id IS '(ИД оператора абонента)';

COMMENT ON COLUMN clients.registration_date IS '(Дата регистрации)';

COMMENT ON COLUMN clients.head_entity_instance_id IS '(ИД сущности, которая является изначальным тарифом для данного абонента)';

COMMENT ON COLUMN clients.balance IS '(Баланс абонента)';

COMMENT ON COLUMN clients.balance_currency_id IS '(ИД валюты баланса)';

COMMENT ON COLUMN clients.region_id IS '(ИД региона абонента)';

COMMENT ON COLUMN clients.is_sended IS '(0 - Абонент не отправлен для тарификации / 1 - Абонент отправлен для тарификации)';

COMMENT ON COLUMN clients.description IS '(Информация об абоненте)';

CREATE TABLE entity_parameters
(
  entity_parameter_id   int NOT NULL UNIQUE,
  client_entity_id      int NOT NULL,
  parameter_instance_id int NOT NULL,
  parameter_value       int NOT NULL,
  PRIMARY KEY (entity_parameter_id)
);

COMMENT ON TABLE entity_parameters IS 'Таблица параметров сущностей';

COMMENT ON COLUMN entity_parameters.entity_parameter_id IS '(ИД)';

COMMENT ON COLUMN entity_parameters.client_entity_id IS '(ИД сущности)';

COMMENT ON COLUMN entity_parameters.parameter_instance_id IS '(ИД параметра)';

COMMENT ON COLUMN entity_parameters.parameter_value IS '(Количество оставшихся ресурсов)';

CREATE TABLE operators
(
  operator_id   int         NOT NULL UNIQUE,
  operator_name varchar(30) UNIQUE,
  PRIMARY KEY (operator_id)
);

COMMENT ON TABLE operators IS 'Таблица операторов, которых мы обслуживаем';

COMMENT ON COLUMN operators.operator_id IS '(ИД)';

COMMENT ON COLUMN operators.operator_name IS '(Название оператора)';

ALTER TABLE client_entities
  ADD CONSTRAINT FK_clients_TO_client_entities
    FOREIGN KEY (client_id)
    REFERENCES clients (client_id);

ALTER TABLE entity_parameters
  ADD CONSTRAINT FK_client_entities_TO_entity_parameters
    FOREIGN KEY (client_entity_id)
    REFERENCES client_entities (client_entity_id);

ALTER TABLE calls
  ADD CONSTRAINT FK_operators_TO_calls
    FOREIGN KEY (left_operator_id)
    REFERENCES operators (operator_id);

ALTER TABLE calls
  ADD CONSTRAINT FK_operators_TO_calls1
    FOREIGN KEY (right_operator_id)
    REFERENCES operators (operator_id);

ALTER TABLE clients
  ADD CONSTRAINT FK_operators_TO_clients
    FOREIGN KEY (operator_id)
    REFERENCES operators (operator_id);

ALTER TABLE calls
  ADD CONSTRAINT FK_call_types_TO_calls
    FOREIGN KEY (call_type_id)
    REFERENCES call_types (call_type_id);
