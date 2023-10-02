set schema 'SSQA';

-- Ajout contrainte pour la table variable
create function verifier_validation() returns trigger as $$
begin
    if (not exists (select 1 from variable where variable.code = new.variable and variable.valref between new.min and new.max)) then
        raise exception 'L''intervalle de validation est invalide';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger verifier_validation_trigger before insert or update on validation for each row execute function verifier_validation();

-- Ajout contrainte pour la table exigence
create function valider_exigence() returns trigger as $$
begin
    if (not exists (select 1 from validation v where v.variable = new.variable and new.min between v.min and v.max)) then
        raise exception 'La valeur minimale de l''exigence est invalide';
    end if;
    if (not exists (select 1 from validation v where v.variable = new.variable and new.max between v.min and v.max)) then
        raise exception 'La valeur maximale de l''exigence est invalide';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger valider_exigence_trigger before insert or update on exigence for each row execute function valider_exigence();