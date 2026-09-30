CREATE TABLE ticket (
    ticket_id      UUID PRIMARY KEY,
    commuter_id    UUID NOT NULL REFERENCES commuter(commuter_id),
    fare_type      VARCHAR(30)  NOT NULL,
    status         VARCHAR(20)  NOT NULL,
    issued_at      TIMESTAMPTZ  NOT NULL,
    fare_amount    NUMERIC(8,2) NOT NULL
);

CREATE TABLE payment (
    payment_id     UUID PRIMARY KEY,
    ticket_id      UUID NOT NULL REFERENCES ticket(ticket_id),
    provider       VARCHAR(30)  NOT NULL,
    status         VARCHAR(20)  NOT NULL,
    amount         NUMERIC(8,2) NOT NULL,
    gateway_ref    VARCHAR(64)
);

CREATE TABLE validation_event (
    validation_id  UUID PRIMARY KEY,
    ticket_id      UUID NOT NULL REFERENCES ticket(ticket_id),
    vehicle_id     UUID NOT NULL REFERENCES vehicle(vehicle_id),
    validated_at   TIMESTAMPTZ  NOT NULL,
    location       VARCHAR(100) NOT NULL
);

CREATE TABLE fraud_event (
    fraud_id       UUID PRIMARY KEY,
    validation_id  UUID NOT NULL REFERENCES validation_event(validation_id),
    description    TEXT NOT NULL,
    reported_at    TIMESTAMPTZ NOT NULL,
    resolved       BOOLEAN NOT NULL DEFAULT FALSE 
);

CREATE TABLE vehicle (
    vehicle_id     UUID PRIMARY KEY,
    vehicle_type   VARCHAR(30) NOT NULL,
    license_plate  VARCHAR(20) NOT NULL,
    capacity       INT NOT NULL
);

CREATE TABLE vehicle_position (
    position_id    UUID PRIMARY KEY,
    vehicle_id     UUID NOT NULL REFERENCES vehicle(vehicle_id),
    latitude       NUMERIC(9,6) NOT NULL,
    longitude      NUMERIC(9,6) NOT NULL,
    recorded_at    TIMESTAMPTZ NOT NULL
);

CREATE TABLE commuter (
    commuter_id    UUID PRIMARY KEY,
    display_name   VARCHAR(100),
    preferred_lang VARCHAR(20),
    created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);