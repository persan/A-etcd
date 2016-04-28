
with Ada.Finalization;

package Etcd is
   type Sesion is new Ada.Finalization.Limited_Controlled with private;

   procedure Open (Self : in out Sesion; Server : String);
   procedure Close (Self : in out Sesion; Server : String);

   function Get (Self : in Sesion; Key : String) return String;

   procedure Set (Self    : in out Sesion;
                  Key     : String;
                  Value   : String;
                  Precond : String;
                  TTL     : Duration);

   procedure Delete (Self : in out Sesion; Key : String);
   function Leader (Self : in out Sesion) return String;

private

   type Handle;
   type Handle_Access is access all Handle;
   type Sesion is new Ada.Finalization.Limited_Controlled with record
      Connection : Handle_Access;
   end record;

   overriding procedure Initialize (Object : in out Sesion);
   overriding procedure Finalize   (Object : in out Sesion);

end Etcd;
