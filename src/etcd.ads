with Ada.Finalization;
with GNAT.Strings;
package Etcd is
   type Sesion is new Ada.Finalization.Limited_Controlled with private;

   procedure Open (Self : in out Sesion; Servers : String);
   procedure Open (Self : in out Sesion; Servers : GNAT.Strings.String_List);
   procedure Close (Self : in out Sesion; Servers : String);


   function Get (Self : in out Sesion; Key : String) return String;
   procedure Set (Self    : in out Sesion;
                  Key     : String;
                  Value   : String;
                  Precond : String;
                  TTL     : Duration);

   --     procedure Watch (Self : in out Sesion;
   --                      Pfx  : String);

   procedure Delete (Self : in out Sesion; Key : String);
   function Leader (Self : in out Sesion) return String;



private
   type Sesion is new Ada.Finalization.Limited_Controlled with record
      Dummy : Integer;
   end record;

end Etcd;
