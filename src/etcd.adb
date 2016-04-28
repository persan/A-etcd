with Ada.Unchecked_Deallocation;
with Ada.Strings.Fixed.Hash;
with Ada.Containers.Indefinite_Hashed_Sets;
with AWS.Client;
with AWS.Response;
package body Etcd is

   package String_Sets is new Ada.Containers.Indefinite_Hashed_Sets
     (Element_Type        =>  String,
      Hash                => Ada.Strings.Fixed.Hash,
      Equivalent_Elements => "=", "=" => "=");
   type Handle is record
      Servers : String_Sets.Set;
   end record;

   ----------
   -- Open --
   ----------

   procedure Open (Self : in out Sesion; Server : String) is
   begin
      Self.Connection.Servers.Include (Server);
   end Open;

   -----------
   -- Close --
   -----------

   procedure Close (Self : in out Sesion; Server : String) is
   begin
      if Self.Connection.Servers.Contains (Server) then
         Self.Connection.Servers.Delete (Server);
      end if;
   end Close;

   ---------
   -- Get --
   ---------

   function Get (Self : in Sesion; Key : String) return String is

   begin
      for Server of Self.Connection.Servers loop
         begin
            return AWS.Response.Message_Body
              (AWS.Client.Get (Server & "/?key=" & Key,
               User     => "",
               Pwd      => "",
               Timeouts => AWS.Client.No_Timeout));
         exception
            when others => null;
         end;
      end loop;
      return "";
   end Get;

   ---------
   -- Set --
   ---------

   procedure Set
     (Self    : in out Sesion;
      Key     : String;
      Value   : String;
      Precond : String;
      TTL     : Duration)
   is
      pragma Unreferenced (Self);
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set unimplemented");
      raise Program_Error with "Unimplemented procedure Set";
   end Set;

   ------------
   -- Delete --
   ------------

   procedure Delete (Self : in out Sesion; Key : String) is
   begin
      for Server of Self.Connection.Servers loop
         begin
            Self.Parse_Json (AWS.Response.Message_Body
                             (AWS.Client.Post (Server & "/?key=" & Key,
                                User     => "",
                                Pwd      => "",
                                Timeouts => AWS.Client.No_Timeout)));
         exception
            when others => null;
         end;
      end loop;
   end Delete;

   ------------
   -- Leader --
   ------------

   function Leader (Self : in out Sesion) return String is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Leader unimplemented");
      raise Program_Error with "Unimplemented function Leader";
      return Leader (Self => Self);
   end Leader;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Object : in out Sesion) is
   begin
      Object.Connection := new Handle;
   end Initialize;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Object : in out Sesion) is
      procedure Free is new Ada.Unchecked_Deallocation (Handle, Handle_Access);
   begin
      Free (Object.Connection);
   end Finalize;

end Etcd;
