open Core_kernel
module S = IECCheckerCore.Syntax
module Scope = IECCheckerCore.Scope
module TI = IECCheckerCore.Tok_info

let print_element (e : S.iec_library_element) =
  match e with
  | S.IECFunction f ->
      Printf.printf "Running check for function %s\n" (S.Function.get_name f.id)
  | S.IECFunctionBlock fb ->
      Printf.printf "Running check for function block %s\n"
        (S.FunctionBlock.get_name fb.id)
  | S.IECProgram p -> Printf.printf "Running check for program %s\n" p.name
  | S.IECConfiguration c ->
      Printf.printf "Running check for configuration %s\n" c.name

let[@warning "-27"] run_all_checks elements scopes =
  List.iter elements ~f:(fun e -> print_element e);
  Plcopen_n3.do_check elements |> List.append (Plcopen_l17.do_check elements)
