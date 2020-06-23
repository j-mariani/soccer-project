create or replace function cancella_operazioni_incontro(incontro_id integer, nome_operatore varchar(20), data timestamp without time zone) returns integer AS $$
declare
    num1 integer;
begin

    delete from operazioni_incontri where operazioni_incontri.incontro_id=$1 and operazioni_incontri.nome_operatore=$2 and operazioni_incontri.data=$3;

    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;