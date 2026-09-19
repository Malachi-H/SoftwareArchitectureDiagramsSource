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
