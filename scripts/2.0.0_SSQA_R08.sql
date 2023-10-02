set schema 'SSQA';

-- Vérification à l'ajout dans la table Exigence que periode_unite est bien une unité de temps
-- On vérifie que l'unite referencée dans periode_unite n'a qu'une correspondance dans la table composition_unite et que son symbole_unite_fondamentale est 's'
create function verifier_periode_unite() returns trigger as $$
begin
    if (not exists (select 1 from composition_unite join unite on unite.sym = composition_unite.symbole_unite_composite where unite.sym = new.periode_unite and composition_unite.symbole_unite_fondamentale = 's' group by composition_unite.symbole_unite_composite having count(*) = 1)) then
        raise exception 'L''unité de la période n''est pas une unité de temps';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger verifier_periode_unite_trigger before insert or update on exigence for each row execute function verifier_periode_unite();