public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    switch(dialogid) {
        case D_REGISTRO: {
            if(!response) return Kick(playerid);
            new password[64 + 1];
            SHA256_PassHash(inputtext, "", password, sizeof password);
            format(password, sizeof(password), "%s", password);
            user[playerid][jClave] = password;

            CrearCuenta(playerid);
            printf("La contraseña de %s, es: %s", PlayerName(playerid), SHA256_PassHash(inputtext, "", user[playerid][jClave], 64 + 1));
        }
        case D_INGRESO: {
            if(!response) return Kick(playerid);
            new query[520], password[64 + 1];
            SHA256_PassHash(inputtext, "", password, sizeof password);
            format(password, sizeof(password), "%s", password);
            mysql_format(MySQL,query,sizeof(query),"SELECT * FROM `cuentas` WHERE `Nombre`='%s' AND `Password`='%s'", PlayerName(playerid), password);
            mysql_pquery(MySQL, query, "IngresoJugador","d", playerid);
        }
    }
    return 1;
}
