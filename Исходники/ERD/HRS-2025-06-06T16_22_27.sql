
CREATE TABLE access
(
  access_id   INT         NOT NULL UNIQUE,
  access_name VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (access_id)
);

COMMENT ON TABLE access IS 'Таблица доступа';

COMMENT ON COLUMN access.access_id IS '(ИД)';

COMMENT ON COLUMN access.access_name IS '(Название доступа к тарифу: Открытый / Корпоративный)';

CREATE TABLE currency
(
  curency_id    INT         NOT NULL UNIQUE,
  currency_name varchar(20) NOT NULL UNIQUE,
  PRIMARY KEY (curency_id)
);

COMMENT ON TABLE currency IS 'Таблица валюты ';

COMMENT ON COLUMN currency.curency_id IS '(ИД)';

COMMENT ON COLUMN currency.currency_name IS '(Название валюты)';

CREATE TABLE entities
(
  entity_id      INT         NOT NULL UNIQUE,
  entity_name    VARCHAR(30) NOT NULL,
  entity_type_id INT         NOT NULL,
  description    VARCHAR(50),
  PRIMARY KEY (entity_id)
);

COMMENT ON TABLE entities IS 'Таблица сущностей';

COMMENT ON COLUMN entities.entity_id IS '(ИД)';

COMMENT ON COLUMN entities.entity_name IS '(Название сущности)';

COMMENT ON COLUMN entities.entity_type_id IS '(Тип сущности: Тариф / Пакет звонков / Пакет интернета и т.д.) ';

COMMENT ON COLUMN entities.description IS '(Описание)';

CREATE TABLE entity_connections
(
  entity_connection_id  INT NOT NULL UNIQUE,
  head_entity_id        INT NOT NULL,
  parent_entity_id      INT NOT NULL,
  child_entity_id       INT NOT NULL,
  priority              INT NOT NULL,
  fallback_condition_id INT NOT NULL,
  PRIMARY KEY (entity_connection_id)
);

COMMENT ON TABLE entity_connections IS 'Таблица связи сущностей ';

COMMENT ON COLUMN entity_connections.entity_connection_id IS '(ИД)';

COMMENT ON COLUMN entity_connections.head_entity_id IS '(Корневая сущность)';

COMMENT ON COLUMN entity_connections.parent_entity_id IS '(Родительская сущность)';

COMMENT ON COLUMN entity_connections.child_entity_id IS '(Дочерняя сущность)';

COMMENT ON COLUMN entity_connections.priority IS '(Приоритет)';

COMMENT ON COLUMN entity_connections.fallback_condition_id IS '(ИД условия смены сущности)';

CREATE TABLE entity_instances
(
  entity_instance_id INT         NOT NULL UNIQUE,
  entity_id          INT         NOT NULL,
  access_id          INT         NOT NULL,
  region_id          INT         NOT NULL,
  pricing_id         INT         NOT NULL,
  start_date         DATE        NOT NULL,
  end_date           DATE       ,
  status_id          INT         NOT NULL,
  description        VARCHAR(50),
  PRIMARY KEY (entity_instance_id)
);

COMMENT ON TABLE entity_instances IS 'Таблица объектов сущностей';

COMMENT ON COLUMN entity_instances.entity_instance_id IS '(ИД)';

COMMENT ON COLUMN entity_instances.entity_id IS '(ИД сущности)';

COMMENT ON COLUMN entity_instances.access_id IS '(ИД доступа)';

COMMENT ON COLUMN entity_instances.region_id IS '(ИД региона)';

COMMENT ON COLUMN entity_instances.pricing_id IS '(ИД стоимости)';

COMMENT ON COLUMN entity_instances.start_date IS '(Дата создания объекта)';

COMMENT ON COLUMN entity_instances.end_date IS '(Дата отключения объекта)';

COMMENT ON COLUMN entity_instances.status_id IS '(Статус объекта)';

COMMENT ON COLUMN entity_instances.description IS '(Описание)';

CREATE TABLE entity_parameters
(
  entity_parameter_id int NOT NULL UNIQUE,
  head_entity_id      INT NOT NULL,
  entity_id           INT NOT NULL,
  measurement_unit_id INT NOT NULL,
  parameter_id        INT NOT NULL,
  value               INT NOT NULL,
  PRIMARY KEY (entity_parameter_id)
);

COMMENT ON TABLE entity_parameters IS 'Таблица параметров сущностей';

COMMENT ON COLUMN entity_parameters.entity_parameter_id IS '(ИД)';

COMMENT ON COLUMN entity_parameters.head_entity_id IS '(ИД головной сущности)';

COMMENT ON COLUMN entity_parameters.entity_id IS '(ИД сущности)';

COMMENT ON COLUMN entity_parameters.measurement_unit_id IS '(ИД единицы измерения)';

COMMENT ON COLUMN entity_parameters.parameter_id IS '(ИД параметра)';

COMMENT ON COLUMN entity_parameters.value IS '(Значение параметра)';

CREATE TABLE entity_types
(
  entity_type_id   INT         NOT NULL UNIQUE,
  entity_type_name VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (entity_type_id)
);

COMMENT ON TABLE entity_types IS 'Таблица типов сущностей';

COMMENT ON COLUMN entity_types.entity_type_id IS '(ИД)';

COMMENT ON COLUMN entity_types.entity_type_name IS '(Название типа сущности)';

CREATE TABLE fallback_conditions
(
  fallback_condition_id INT         NOT NULL UNIQUE,
  fallback_condition    VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (fallback_condition_id)
);

COMMENT ON TABLE fallback_conditions IS 'Таблица условий смены сущностей';

COMMENT ON COLUMN fallback_conditions.fallback_condition_id IS '(ИД)';

COMMENT ON COLUMN fallback_conditions.fallback_condition IS '(Описание условия смены сущности)';

CREATE TABLE measurement_units
(
  measurement_unit_id   INT         NOT NULL UNIQUE,
  measurement_unit_name VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (measurement_unit_id)
);

COMMENT ON TABLE measurement_units IS 'Таблица единиц измерения';

COMMENT ON COLUMN measurement_units.measurement_unit_id IS '(ИД)';

COMMENT ON COLUMN measurement_units.measurement_unit_name IS '(Название единицы измерения)';

CREATE TABLE parameter_instances
(
  parameter_instance_id INT         NOT NULL UNIQUE,
  parameter_id          INT         NOT NULL,
  pricing_id            INT         NOT NULL,
  entity_instance_id    INT         NOT NULL,
  description           VARCHAR(50),
  PRIMARY KEY (parameter_instance_id)
);

COMMENT ON TABLE parameter_instances IS 'Таблица объектов параметров';

COMMENT ON COLUMN parameter_instances.parameter_instance_id IS '(ИД)';

COMMENT ON COLUMN parameter_instances.parameter_id IS '(ИД параметра)';

COMMENT ON COLUMN parameter_instances.pricing_id IS '(ИД стоимости)';

COMMENT ON COLUMN parameter_instances.entity_instance_id IS '(ИД соответствующей сущности)';

COMMENT ON COLUMN parameter_instances.description IS '(Описание)';

CREATE TABLE parameters
(
  parameter_id   INT         NOT NULL UNIQUE,
  parameter_name VARCHAR(30) NOT NULL UNIQUE,
  description    VARCHAR(50),
  PRIMARY KEY (parameter_id)
);

COMMENT ON TABLE parameters IS 'Таблица параметров';

COMMENT ON COLUMN parameters.parameter_id IS '(ИД)';

COMMENT ON COLUMN parameters.parameter_name IS '(Название параметра)';

COMMENT ON COLUMN parameters.description IS '(Описание)';

CREATE TABLE payment_types
(
  payment_type_id INT         NOT NULL UNIQUE,
  payment_type    VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (payment_type_id)
);

COMMENT ON TABLE payment_types IS 'Таблица типов оплаты';

COMMENT ON COLUMN payment_types.payment_type_id IS '(ИД)';

COMMENT ON COLUMN payment_types.payment_type IS '(Описание типа оплаты)';

CREATE TABLE pricing
(
  pricing_id      INT           NOT NULL UNIQUE,
  payment_level   INT           NOT NULL,
  payment_type_id INT           NOT NULL,
  curency_id      INT           NOT NULL,
  price_for_use   DECIMAL(10,1) NOT NULL,
  PRIMARY KEY (pricing_id)
);

COMMENT ON TABLE pricing IS 'Таблица стоимости сущностей/параметров ';

COMMENT ON COLUMN pricing.pricing_id IS '(ИД)';

COMMENT ON COLUMN pricing.payment_level IS '(Сущность на каком уровне вложенности тарифа отвечает за оплату)';

COMMENT ON COLUMN pricing.payment_type_id IS '(ИД типа оплаты)';

COMMENT ON COLUMN pricing.curency_id IS '(ИД валюты)';

COMMENT ON COLUMN pricing.price_for_use IS '(Цена использования)';

CREATE TABLE regions
(
  region_id   INT         NOT NULL UNIQUE,
  region_name VARCHAR(30) NOT NULL UNIQUE,
  PRIMARY KEY (region_id)
);

COMMENT ON TABLE regions IS 'Таблица регионов';

COMMENT ON COLUMN regions.region_id IS '(ИД)';

COMMENT ON COLUMN regions.region_name IS '(Название региона)';

CREATE TABLE statuses
(
  status_id   INT         NOT NULL UNIQUE,
  status_name VARCHAR(30) UNIQUE,
  PRIMARY KEY (status_id)
);

COMMENT ON TABLE statuses IS 'Таблица статусов ';

COMMENT ON COLUMN statuses.status_id IS '(ИД)';

COMMENT ON COLUMN statuses.status_name IS '(Название статуса: Активный / В архиве)';

ALTER TABLE entity_connections
  ADD CONSTRAINT FK_entities_TO_entity_connections
    FOREIGN KEY (head_entity_id)
    REFERENCES entities (entity_id);

ALTER TABLE entity_connections
  ADD CONSTRAINT FK_entities_TO_entity_connections1
    FOREIGN KEY (parent_entity_id)
    REFERENCES entities (entity_id);

ALTER TABLE entity_connections
  ADD CONSTRAINT FK_entities_TO_entity_connections2
    FOREIGN KEY (child_entity_id)
    REFERENCES entities (entity_id);

ALTER TABLE entities
  ADD CONSTRAINT FK_entity_types_TO_entities
    FOREIGN KEY (entity_type_id)
    REFERENCES entity_types (entity_type_id);

ALTER TABLE entity_parameters
  ADD CONSTRAINT FK_entities_TO_entity_parameters
    FOREIGN KEY (head_entity_id)
    REFERENCES entities (entity_id);

ALTER TABLE entity_parameters
  ADD CONSTRAINT FK_entities_TO_entity_parameters1
    FOREIGN KEY (entity_id)
    REFERENCES entities (entity_id);

ALTER TABLE entity_parameters
  ADD CONSTRAINT FK_measurement_units_TO_entity_parameters
    FOREIGN KEY (measurement_unit_id)
    REFERENCES measurement_units (measurement_unit_id);

ALTER TABLE entity_parameters
  ADD CONSTRAINT FK_parameters_TO_entity_parameters
    FOREIGN KEY (parameter_id)
    REFERENCES parameters (parameter_id);

ALTER TABLE parameter_instances
  ADD CONSTRAINT FK_parameters_TO_parameter_instances
    FOREIGN KEY (parameter_id)
    REFERENCES parameters (parameter_id);

ALTER TABLE parameter_instances
  ADD CONSTRAINT FK_pricing_TO_parameter_instances
    FOREIGN KEY (pricing_id)
    REFERENCES pricing (pricing_id);

ALTER TABLE pricing
  ADD CONSTRAINT FK_payment_types_TO_pricing
    FOREIGN KEY (payment_type_id)
    REFERENCES payment_types (payment_type_id);

ALTER TABLE pricing
  ADD CONSTRAINT FK_currency_TO_pricing
    FOREIGN KEY (curency_id)
    REFERENCES currency (curency_id);

ALTER TABLE entity_instances
  ADD CONSTRAINT FK_pricing_TO_entity_instances
    FOREIGN KEY (pricing_id)
    REFERENCES pricing (pricing_id);

ALTER TABLE entity_instances
  ADD CONSTRAINT FK_entities_TO_entity_instances
    FOREIGN KEY (entity_id)
    REFERENCES entities (entity_id);

ALTER TABLE entity_instances
  ADD CONSTRAINT FK_statuses_TO_entity_instances
    FOREIGN KEY (status_id)
    REFERENCES statuses (status_id);

ALTER TABLE entity_instances
  ADD CONSTRAINT FK_access_TO_entity_instances
    FOREIGN KEY (access_id)
    REFERENCES access (access_id);

ALTER TABLE entity_instances
  ADD CONSTRAINT FK_regions_TO_entity_instances
    FOREIGN KEY (region_id)
    REFERENCES regions (region_id);

ALTER TABLE parameter_instances
  ADD CONSTRAINT FK_entity_instances_TO_parameter_instances
    FOREIGN KEY (entity_instance_id)
    REFERENCES entity_instances (entity_instance_id);

ALTER TABLE entity_connections
  ADD CONSTRAINT FK_fallback_conditions_TO_entity_connections
    FOREIGN KEY (fallback_condition_id)
    REFERENCES fallback_conditions (fallback_condition_id);
