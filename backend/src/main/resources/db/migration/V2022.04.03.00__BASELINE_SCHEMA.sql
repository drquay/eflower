
    create table account_has_privileges (
       account_id varchar(255) not null,
        privilege_id varchar(255) not null,
        primary key (account_id, privilege_id)
    );

    create table account_has_roles (
       account_id varchar(255) not null,
        role_id varchar(255) not null,
        primary key (account_id, role_id)
    );

    create table accounts (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        avatar text,
        blocked boolean not null,
        full_name varchar(255),
        password varchar(255) not null,
        phone_number varchar(255),
        username varchar(255) not null,
        primary key (id)
    );

    create table attachments (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        file_extension varchar(255),
        img text,
        name varchar(255),
        parent_id varchar(255),
        url varchar(255),
        primary key (id)
    );

    create table customers (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        address varchar(255),
        full_name varchar(255),
        phone_number varchar(255),
        primary key (id)
    );

    create table notification (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        from_account_id varchar(255),
        message varchar(255),
        message_id varchar(255),
        to_account_id varchar(255),
        to_role_id varchar(255),
        primary key (id)
    );

    create table order_assignment_histories (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        person_in_charse varchar(255),
        order_id varchar(255),
        primary key (id)
    );

    create table order_comments (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        content text,
        order_id varchar(255),
        primary key (id)
    );

    create table order_payment_histories (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        amount numeric(19, 2),
        money_keeper_id varchar(255),
        note text,
        payment_reason varchar(255),
        type varchar(255),
        order_id varchar(255),
        primary key (id)
    );

    create table orders (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        buyer_id varchar(255),
        code varchar(255),
        customer_message varchar(255),
        delivery_date timestamp,
        note_for_florist varchar(255),
        note_for_shipper varchar(255),
        price numeric(19, 2),
        product_id varchar(255),
        receiver_id varchar(255),
        source varchar(255),
        status varchar(255),
        supported_sale_id varchar(255),
        primary key (id)
    );

    create table privileges (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        name varchar(255) not null,
        primary key (id)
    );

    create table products (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        code varchar(255),
        description varchar(255),
        name varchar(255),
        price numeric(19, 2),
        reference_url varchar(255),
        primary key (id)
    );

    create table role_has_privileges (
       role_id varchar(255) not null,
        privilege_id varchar(255) not null,
        primary key (role_id, privilege_id)
    );

    create table roles (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        active boolean not null,
        name varchar(255) not null,
        primary key (id)
    );

    create table shipper_route_details (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        order_id varchar(255),
        to_latitude varchar(255),
        to_longitude varchar(255),
        route_id varchar(255),
        primary key (id)
    );

    create table shipper_routes (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        begin_latitude varchar(255),
        begin_longitude varchar(255),
        end_latitude varchar(255),
        end_longitude varchar(255),
        number_of_km float4,
        shipper_id varchar(255) not null,
        primary key (id)
    );

    create table system_configurations (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        key varchar(255),
        value varchar(255),
        primary key (id)
    );

    create table tracing (
       id varchar(255) not null,
        created_by varchar(255) not null,
        created_on timestamp not null,
        version int8,
        request_body jsonb,
        request_header jsonb,
        service_response jsonb,
        primary key (id)
    );

    alter table privileges
       add constraint UK_m2tnonbcaquofx1ccy060ejyc unique (name);

    alter table roles
       add constraint UK_ofx66keruapi6vyqpv6f2or37 unique (name);

    alter table account_has_privileges
       add constraint FKe076s69g13wjgenreqy48evrj
       foreign key (privilege_id)
       references privileges;

    alter table account_has_privileges
       add constraint FKi50j7780s6vpa08ymymklbogx
       foreign key (account_id)
       references accounts;

    alter table account_has_roles
       add constraint FKcyr73ikl7cup64nky4eewcp84
       foreign key (role_id)
       references roles;

    alter table account_has_roles
       add constraint FKfploxvumeidox4fb8bpbhnodh
       foreign key (account_id)
       references accounts;

    alter table order_assignment_histories
       add constraint FK2bjm95o1ninf9b7b1own3yvwi
       foreign key (order_id)
       references orders;

    alter table order_comments
       add constraint FKcvjutrje88c98aqdc1sviag64
       foreign key (order_id)
       references orders;

    alter table order_payment_histories
       add constraint FK6rwvavxr1kjkvje0gxju8nkeg
       foreign key (order_id)
       references orders;

    alter table role_has_privileges
       add constraint FK9ucjhmmqwhs0qx112iitwxk2w
       foreign key (privilege_id)
       references privileges;

    alter table role_has_privileges
       add constraint FKdd54kqmmhh5seugyg4q5nvexu
       foreign key (role_id)
       references roles;

    alter table shipper_route_details
       add constraint FKqfeq8bscrt71t8d89rxdugyqm
       foreign key (route_id)
       references shipper_routes;
