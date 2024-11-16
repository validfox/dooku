//['dooku.py', '-i', 'example/gate.xlsx', '-o', 'example/', '-ral', '-rtl']
//./gate.csv
//1116144506 wufei earth undefine .
//gate 0x0 10 32 1024
//Checked in    : $Date: $
//Revision      : $Revision: $
import uvm_pkg::*;
`include "uvm_macros.svh"
package gate_regs_pkg;
class gate_handle extends uvm_reg;
	`uvm_object_utils(gate_handle)
	rand uvm_reg_field en; //{RW,SWRST:swrst,HardwareUpdate}
	rand uvm_reg_field mode; //{RW,SWRST:swrst}
	rand uvm_reg_field sts0; //{RO,SWRST:swrst}
	rand uvm_reg_field sts1; //{RO,SWRST:swrst,Volatile}
	function new(string name="gate_handle");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		en = uvm_reg_field::type_id::create("en"); //{RW,SWRST:swrst,HardwareUpdate}
		en.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		en.set_compare(UVM_NO_CHECK); //TODO
		mode = uvm_reg_field::type_id::create("mode"); //{RW,SWRST:swrst}
		mode.configure(.parent(this),.size(4),.lsb_pos(4),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		mode.set_compare(UVM_NO_CHECK); //TODO
		sts0 = uvm_reg_field::type_id::create("sts0"); //{RO,SWRST:swrst}
		sts0.configure(.parent(this),.size(10),.lsb_pos(16),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		sts0.set_compare(UVM_NO_CHECK); //TODO
		sts1 = uvm_reg_field::type_id::create("sts1"); //{RO,SWRST:swrst,Volatile}
		sts1.configure(.parent(this),.size(1),.lsb_pos(31),.access("RO"),.volatile(1),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		sts1.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_handle
class gate_beep extends uvm_reg;
	`uvm_object_utils(gate_beep)
	rand uvm_reg_field en; //{RW}
	rand uvm_reg_field mode; //{RW,SWRST:swrst,EN:enbeep}
	rand uvm_reg_field tone; //{WO,SWRST:swrst,HardwareUpdate}
	function new(string name="gate_beep");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		en = uvm_reg_field::type_id::create("en"); //{RW}
		en.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		en.set_compare(UVM_NO_CHECK); //TODO
		mode = uvm_reg_field::type_id::create("mode"); //{RW,SWRST:swrst,EN:enbeep}
		mode.configure(.parent(this),.size(4),.lsb_pos(4),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		mode.set_compare(UVM_NO_CHECK); //TODO
		tone = uvm_reg_field::type_id::create("tone"); //{WO,SWRST:swrst,HardwareUpdate}
		tone.configure(.parent(this),.size(1),.lsb_pos(16),.access("WO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		tone.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_beep
class gate_beepsd extends uvm_reg;
	`uvm_object_utils(gate_beepsd)
	rand uvm_reg_field modes; //{RW,SWRST:swrst,Link:beep.mode}
	rand uvm_reg_field modet; //{WO,SWRST:swrst,Link:beep.mode}
	rand uvm_reg_field moder; //{RO,SWRST:swrst,Link:beep.mode}
	function new(string name="gate_beepsd");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		modes = uvm_reg_field::type_id::create("modes"); //{RW,SWRST:swrst,Link:beep.mode}
		modes.configure(.parent(this),.size(4),.lsb_pos(0),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		modes.set_compare(UVM_NO_CHECK); //TODO
		modet = uvm_reg_field::type_id::create("modet"); //{WO,SWRST:swrst,Link:beep.mode}
		modet.configure(.parent(this),.size(4),.lsb_pos(4),.access("WO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		modet.set_compare(UVM_NO_CHECK); //TODO
		moder = uvm_reg_field::type_id::create("moder"); //{RO,SWRST:swrst,Link:beep.mode}
		moder.configure(.parent(this),.size(4),.lsb_pos(8),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		moder.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_beepsd
class gate_bigshadow extends uvm_reg;
	`uvm_object_utils(gate_bigshadow)
	rand uvm_reg_field hen; //{RO,SWRST:swrst,Link:handle.en}
	rand uvm_reg_field ben0; //{RO,SWRST:swrst,Link:beep[0].en}
	rand uvm_reg_field ben1; //{RO,SWRST:swrst,Link:beep[1].en}
	function new(string name="gate_bigshadow");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		hen = uvm_reg_field::type_id::create("hen"); //{RO,SWRST:swrst,Link:handle.en}
		hen.configure(.parent(this),.size(1),.lsb_pos(0),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		hen.set_compare(UVM_NO_CHECK); //TODO
		ben0 = uvm_reg_field::type_id::create("ben0"); //{RO,SWRST:swrst,Link:beep[0].en}
		ben0.configure(.parent(this),.size(1),.lsb_pos(1),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		ben0.set_compare(UVM_NO_CHECK); //TODO
		ben1 = uvm_reg_field::type_id::create("ben1"); //{RO,SWRST:swrst,Link:beep[1].en}
		ben1.configure(.parent(this),.size(1),.lsb_pos(2),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		ben1.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_bigshadow
class gate_shadowarray extends uvm_reg;
	`uvm_object_utils(gate_shadowarray)
	rand uvm_reg_field hen; //{RO,SWRST:swrst,Link:handle.en}
	rand uvm_reg_field ben; //{RO,SWRST:swrst,Link:beep.en}
	rand uvm_reg_field hben; //{RO,SWRST:swrst,Link:[0]=handle.en,[1]=beep[0].en}
	function new(string name="gate_shadowarray");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		hen = uvm_reg_field::type_id::create("hen"); //{RO,SWRST:swrst,Link:handle.en}
		hen.configure(.parent(this),.size(1),.lsb_pos(0),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		hen.set_compare(UVM_NO_CHECK); //TODO
		ben = uvm_reg_field::type_id::create("ben"); //{RO,SWRST:swrst,Link:beep.en}
		ben.configure(.parent(this),.size(1),.lsb_pos(1),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		ben.set_compare(UVM_NO_CHECK); //TODO
		hben = uvm_reg_field::type_id::create("hben"); //{RO,SWRST:swrst,Link:[0]=handle.en,[1]=beep[0].en}
		hben.configure(.parent(this),.size(1),.lsb_pos(2),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		hben.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_shadowarray
class gate_bicycle extends uvm_reg;
	`uvm_object_utils(gate_bicycle)
	rand uvm_reg_field set; //{WO,SelfClear}
	function new(string name="gate_bicycle");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		set = uvm_reg_field::type_id::create("set"); //{WO,SelfClear}
		set.configure(.parent(this),.size(28),.lsb_pos(1),.access("WO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		set.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_bicycle
class gate_bicycleset extends uvm_reg;
	`uvm_object_utils(gate_bicycleset)
	rand uvm_reg_field setset; //{RO,SWRST:swrst,Link:bicycle.set}
	function new(string name="gate_bicycleset");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		setset = uvm_reg_field::type_id::create("setset"); //{RO,SWRST:swrst,Link:bicycle.set}
		setset.configure(.parent(this),.size(28),.lsb_pos(3),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		setset.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_bicycleset
class gate_tricycle extends uvm_reg;
	`uvm_object_utils(gate_tricycle)
	rand uvm_reg_field tset; //{RO,SWRST:tswrst,Link:bicycle.set}
	function new(string name="gate_tricycle");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		tset = uvm_reg_field::type_id::create("tset"); //{RO,SWRST:tswrst,Link:bicycle.set}
		tset.configure(.parent(this),.size(28),.lsb_pos(2),.access("RO"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		tset.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_tricycle
class gate_google extends uvm_reg;
	`uvm_object_utils(gate_google)
	rand uvm_reg_field beeponeen; //{RW,SWRST:swrst,Link:beep[1].en}
	rand uvm_reg_field handleen; //{RW,SWRST:swrst,EN:googleen,Link:handle.en}
	rand uvm_reg_field engine; //{RW,SWRST:swrst,SelfClear,EN:enable}
	function new(string name="gate_google");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		beeponeen = uvm_reg_field::type_id::create("beeponeen"); //{RW,SWRST:swrst,Link:beep[1].en}
		beeponeen.configure(.parent(this),.size(1),.lsb_pos(1),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		beeponeen.set_compare(UVM_NO_CHECK); //TODO
		handleen = uvm_reg_field::type_id::create("handleen"); //{RW,SWRST:swrst,EN:googleen,Link:handle.en}
		handleen.configure(.parent(this),.size(1),.lsb_pos(2),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		handleen.set_compare(UVM_NO_CHECK); //TODO
		engine = uvm_reg_field::type_id::create("engine"); //{RW,SWRST:swrst,SelfClear,EN:enable}
		engine.configure(.parent(this),.size(2),.lsb_pos(23),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		engine.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_google
class gate_writeone extends uvm_reg;
	`uvm_object_utils(gate_writeone)
	rand uvm_reg_field clear; //{W1C,SWRST:swrst}
	rand uvm_reg_field set; //{W1S,SWRST:swrst}
	function new(string name="gate_writeone");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		clear = uvm_reg_field::type_id::create("clear"); //{W1C,SWRST:swrst}
		clear.configure(.parent(this),.size(8),.lsb_pos(0),.access("W1C"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		clear.set_compare(UVM_NO_CHECK); //TODO
		set = uvm_reg_field::type_id::create("set"); //{W1S,SWRST:swrst}
		set.configure(.parent(this),.size(8),.lsb_pos(8),.access("W1S"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		set.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_writeone
class gate_shadowwriteone extends uvm_reg;
	`uvm_object_utils(gate_shadowwriteone)
	rand uvm_reg_field notclear; //{RW,SWRST:swrst,Link:writeone.set}
	rand uvm_reg_field notset; //{RW,SWRST:swrst,Link:writeone.clear}
	function new(string name="gate_shadowwriteone");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		notclear = uvm_reg_field::type_id::create("notclear"); //{RW,SWRST:swrst,Link:writeone.set}
		notclear.configure(.parent(this),.size(8),.lsb_pos(0),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		notclear.set_compare(UVM_NO_CHECK); //TODO
		notset = uvm_reg_field::type_id::create("notset"); //{RW,SWRST:swrst,Link:writeone.clear}
		notset.configure(.parent(this),.size(8),.lsb_pos(8),.access("RW"),.volatile(0),.reset('h0),.has_reset(1),.is_rand(1),.individually_accessible(0)); //TODO
		notset.set_compare(UVM_NO_CHECK); //TODO
	endfunction: build
endclass: gate_shadowwriteone
class gate_reg_model extends uvm_reg_block;
	`uvm_object_utils(gate_reg_model)
	rand gate_handle HANDLE;
	rand gate_beep BEEP[2];
	rand gate_beepsd BEEPSD[2];
	rand gate_bigshadow BIGSHADOW;
	rand gate_shadowarray SHADOWARRAY[2];
	rand gate_bicycle BICYCLE;
	rand gate_bicycleset BICYCLESET;
	rand gate_tricycle TRICYCLE;
	rand gate_google GOOGLE;
	rand gate_writeone WRITEONE;
	rand gate_shadowwriteone SHADOWWRITEONE;
	function new(string name="");
		super.new(name, UVM_NO_COVERAGE);
	endfunction: new
	function void build;
		default_map = create_map("gate_map", 0, 4, UVM_LITTLE_ENDIAN);
		HANDLE = gate_handle::type_id::create("HANDLE");
		HANDLE.configure(this);
		HANDLE.build();
		HANDLE.add_hdl_path_slice("O.handle.en.data", 0, 1);
		HANDLE.add_hdl_path_slice("O.handle.mode.data", 4, 4);
		HANDLE.add_hdl_path_slice("O.handle.sts0.data", 16, 10);
		HANDLE.add_hdl_path_slice("I.handle.sts1.data", 31, 1);
		uvm_resource_db#(bit)::set({"REG::", HANDLE.get_full_name()}, "RESET_MASK", "'h83FF00F1", this);
		default_map.add_reg(HANDLE, 'h0, "RO");
		for(int i=0; i<2; i++) begin
			BEEP[i] = gate_beep::type_id::create($sformatf("BEEP[%0d]", i));
			BEEP[i].configure(this);
			BEEP[i].build();
			BEEP[i].add_hdl_path_slice($sformatf("O.beep[%0d].en.data", i), 0, 1);
			BEEP[i].add_hdl_path_slice($sformatf("O.beep[%0d].mode.data", i), 4, 4);
			BEEP[i].add_hdl_path_slice($sformatf("O.beep[%0d].tone.data", i), 16, 1);
			uvm_resource_db#(bit)::set({"REG::", BEEP[i].get_full_name()}, "RESET_MASK", "'h100F1", this);
			default_map.add_reg(BEEP[i], 'h10+'h4*i, "WO");
		end
		for(int i=0; i<2; i++) begin
			BEEPSD[i] = gate_beepsd::type_id::create($sformatf("BEEPSD[%0d]", i));
			BEEPSD[i].configure(this);
			BEEPSD[i].build();
			BEEPSD[i].add_hdl_path_slice($sformatf("O.beepsd[%0d].modes.data", i), 0, 4);
			BEEPSD[i].add_hdl_path_slice($sformatf("O.beepsd[%0d].modet.data", i), 4, 4);
			BEEPSD[i].add_hdl_path_slice($sformatf("O.beepsd[%0d].moder.data", i), 8, 4);
			uvm_resource_db#(bit)::set({"REG::", BEEPSD[i].get_full_name()}, "RESET_MASK", "'hFFF", this);
			default_map.add_reg(BEEPSD[i], 'h100+'h10*i, "RO");
		end
		BIGSHADOW = gate_bigshadow::type_id::create("BIGSHADOW");
		BIGSHADOW.configure(this);
		BIGSHADOW.build();
		BIGSHADOW.add_hdl_path_slice("O.bigshadow.hen.data", 0, 1);
		BIGSHADOW.add_hdl_path_slice("O.bigshadow.ben0.data", 1, 1);
		BIGSHADOW.add_hdl_path_slice("O.bigshadow.ben1.data", 2, 1);
		uvm_resource_db#(bit)::set({"REG::", BIGSHADOW.get_full_name()}, "RESET_MASK", "'h7", this);
		default_map.add_reg(BIGSHADOW, 'h1000, "RO");
		for(int i=0; i<2; i++) begin
			SHADOWARRAY[i] = gate_shadowarray::type_id::create($sformatf("SHADOWARRAY[%0d]", i));
			SHADOWARRAY[i].configure(this);
			SHADOWARRAY[i].build();
			SHADOWARRAY[i].add_hdl_path_slice($sformatf("O.shadowarray[%0d].hen.data", i), 0, 1);
			SHADOWARRAY[i].add_hdl_path_slice($sformatf("O.shadowarray[%0d].ben.data", i), 1, 1);
			SHADOWARRAY[i].add_hdl_path_slice($sformatf("O.shadowarray[%0d].hben.data", i), 2, 1);
			uvm_resource_db#(bit)::set({"REG::", SHADOWARRAY[i].get_full_name()}, "RESET_MASK", "'h7", this);
			default_map.add_reg(SHADOWARRAY[i], 'h1004+'h4*i, "RO");
		end
		BICYCLE = gate_bicycle::type_id::create("BICYCLE");
		BICYCLE.configure(this);
		BICYCLE.build();
		BICYCLE.add_hdl_path_slice("O.bicycle.set.data", 1, 28);
		uvm_resource_db#(bit)::set({"REG::", BICYCLE.get_full_name()}, "RESET_MASK", "'h1FFFFFFE", this);
		default_map.add_reg(BICYCLE, 'h2000, "WO");
		BICYCLESET = gate_bicycleset::type_id::create("BICYCLESET");
		BICYCLESET.configure(this);
		BICYCLESET.build();
		BICYCLESET.add_hdl_path_slice("O.bicycleset.setset.data", 3, 28);
		uvm_resource_db#(bit)::set({"REG::", BICYCLESET.get_full_name()}, "RESET_MASK", "'h7FFFFFF8", this);
		default_map.add_reg(BICYCLESET, 'h2004, "RO");
		TRICYCLE = gate_tricycle::type_id::create("TRICYCLE");
		TRICYCLE.configure(this);
		TRICYCLE.build();
		TRICYCLE.add_hdl_path_slice("O.tricycle.tset.data", 2, 28);
		uvm_resource_db#(bit)::set({"REG::", TRICYCLE.get_full_name()}, "RESET_MASK", "'h3FFFFFFC", this);
		default_map.add_reg(TRICYCLE, 'h2008, "RO");
		GOOGLE = gate_google::type_id::create("GOOGLE");
		GOOGLE.configure(this);
		GOOGLE.build();
		GOOGLE.add_hdl_path_slice("O.google.beeponeen.data", 1, 1);
		GOOGLE.add_hdl_path_slice("O.google.handleen.data", 2, 1);
		GOOGLE.add_hdl_path_slice("O.google.engine.data", 23, 2);
		uvm_resource_db#(bit)::set({"REG::", GOOGLE.get_full_name()}, "RESET_MASK", "'h1800006", this);
		default_map.add_reg(GOOGLE, 'h200C, "RW");
		WRITEONE = gate_writeone::type_id::create("WRITEONE");
		WRITEONE.configure(this);
		WRITEONE.build();
		WRITEONE.add_hdl_path_slice("O.writeone.clear.data", 0, 8);
		WRITEONE.add_hdl_path_slice("O.writeone.set.data", 8, 8);
		uvm_resource_db#(bit)::set({"REG::", WRITEONE.get_full_name()}, "RESET_MASK", "'hFFFF", this);
		default_map.add_reg(WRITEONE, 'h2010, "W1S");
		SHADOWWRITEONE = gate_shadowwriteone::type_id::create("SHADOWWRITEONE");
		SHADOWWRITEONE.configure(this);
		SHADOWWRITEONE.build();
		SHADOWWRITEONE.add_hdl_path_slice("O.shadowwriteone.notclear.data", 0, 8);
		SHADOWWRITEONE.add_hdl_path_slice("O.shadowwriteone.notset.data", 8, 8);
		uvm_resource_db#(bit)::set({"REG::", SHADOWWRITEONE.get_full_name()}, "RESET_MASK", "'hFFFF", this);
		default_map.add_reg(SHADOWWRITEONE, 'h2014, "RW");
	endfunction: build
endclass: gate_reg_model
endpackage: gate_regs_pkg