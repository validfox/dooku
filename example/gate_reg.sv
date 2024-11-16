//['dooku.py', '-i', 'example/gate.xlsx', '-o', 'example/', '-ral', '-rtl']
//./gate.csv
//1116144506 wufei earth undefine .
//gate 0x0 10 32 1024
//Checked in    : $Date: $
//Revision      : $Revision: $
package gate_reg_pkg;
	/*Fields*/
	typedef struct {logic data; logic update;} handle_en_t; //{RW,SWRST:swrst,HardwareUpdate}
	typedef struct {logic[3:0] data; logic update;} handle_mode_t; //{RW,SWRST:swrst}
	typedef struct {logic[9:0] data; logic update;} handle_sts0_t; //{RO,SWRST:swrst}
	typedef struct {logic data;} handle_sts1_t; //{RO,SWRST:swrst,Volatile}
	typedef struct {logic data; logic update;} beep_en_t; //{RW}
	typedef struct {logic[3:0] data; logic update;} beep_mode_t; //{RW,SWRST:swrst,EN:enbeep}
	typedef struct {logic data; logic update;} beep_tone_t; //{WO,SWRST:swrst,HardwareUpdate}
	typedef struct {logic[3:0] data; logic update;} beepsd_modes_t; //{RW,SWRST:swrst,Link:beep.mode}
	typedef struct {logic[3:0] data; logic update;} beepsd_modet_t; //{WO,SWRST:swrst,Link:beep.mode}
	typedef struct {logic[3:0] data; logic update;} beepsd_moder_t; //{RO,SWRST:swrst,Link:beep.mode}
	typedef struct {logic data; logic update;} bigshadow_hen_t; //{RO,SWRST:swrst,Link:handle.en}
	typedef struct {logic data; logic update;} bigshadow_ben0_t; //{RO,SWRST:swrst,Link:beep[0].en}
	typedef struct {logic data; logic update;} bigshadow_ben1_t; //{RO,SWRST:swrst,Link:beep[1].en}
	typedef struct {logic data; logic update;} shadowarray_hen_t; //{RO,SWRST:swrst,Link:handle.en}
	typedef struct {logic data; logic update;} shadowarray_ben_t; //{RO,SWRST:swrst,Link:beep.en}
	typedef struct {logic data; logic update;} shadowarray_hben_t; //{RO,SWRST:swrst,Link:[0]=handle.en,[1]=beep[0].en}
	typedef struct {logic[27:0] data; logic update;} bicycle_set_t; //{WO,SelfClear}
	typedef struct {logic[27:0] data; logic update;} bicycleset_setset_t; //{RO,SWRST:swrst,Link:bicycle.set}
	typedef struct {logic[27:0] data; logic update;} tricycle_tset_t; //{RO,SWRST:tswrst,Link:bicycle.set}
	typedef struct {logic data; logic update;} google_beeponeen_t; //{RW,SWRST:swrst,Link:beep[1].en}
	typedef struct {logic data; logic update;} google_handleen_t; //{RW,SWRST:swrst,EN:googleen,Link:handle.en}
	typedef struct {logic[1:0] data; logic update;} google_engine_t; //{RW,SWRST:swrst,SelfClear,EN:enable}
	typedef struct {logic[7:0] data; logic update;} writeone_clear_t; //{W1C,SWRST:swrst}
	typedef struct {logic[7:0] data; logic update;} writeone_set_t; //{W1S,SWRST:swrst}
	typedef struct {logic[7:0] data; logic update;} shadowwriteone_notclear_t; //{RW,SWRST:swrst,Link:writeone.set}
	typedef struct {logic[7:0] data; logic update;} shadowwriteone_notset_t; //{RW,SWRST:swrst,Link:writeone.clear}
	/*I.registers*/
	typedef struct {
		handle_en_t en; //[0]{RW,SWRST:swrst,HardwareUpdate}
		//logic[29:0] resv0; //[30:1]
		handle_sts1_t sts1; //[31]{RO,SWRST:swrst,Volatile}
	} handle_i_t; //INFO: 'h0
	typedef struct {
		//logic[15:0] resv0; //[15:0]
		beep_tone_t tone; //[16]{WO,SWRST:swrst,HardwareUpdate}
		//logic[14:0] resv1; //[31:17]
	} beep_i_t; //INFO: 'h10
	/*O.registers*/
	typedef struct {
		handle_en_t en; //[0]{RW,SWRST:swrst,HardwareUpdate}
		//logic[2:0] resv0; //[3:1]
		handle_mode_t mode; //[7:4]{RW,SWRST:swrst}
		//logic[7:0] resv1; //[15:8]
		handle_sts0_t sts0; //[25:16]{RO,SWRST:swrst}
		//logic[5:0] resv2; //[31:26]
	} handle_o_t; //INFO: 'h0
	typedef struct {
		beep_en_t en; //[0]{RW}
		//logic[2:0] resv0; //[3:1]
		beep_mode_t mode; //[7:4]{RW,SWRST:swrst,EN:enbeep}
		//logic[23:0] resv1; //[31:8]
	} beep_o_t; //INFO: 'h10
	typedef struct {
		beepsd_modes_t modes; //[3:0]{RW,SWRST:swrst,Link:beep.mode}
		//logic[3:0] resv0; //[7:4]
		beepsd_moder_t moder; //[11:8]{RO,SWRST:swrst,Link:beep.mode}
		//logic[19:0] resv1; //[31:12]
	} beepsd_o_t; //INFO: 'h100
	typedef struct {
		bigshadow_hen_t hen; //[0]{RO,SWRST:swrst,Link:handle.en}
		bigshadow_ben0_t ben0; //[1]{RO,SWRST:swrst,Link:beep[0].en}
		bigshadow_ben1_t ben1; //[2]{RO,SWRST:swrst,Link:beep[1].en}
		//logic[28:0] resv0; //[31:3]
	} bigshadow_o_t; //INFO: 'h1000
	typedef struct {
		shadowarray_hen_t hen; //[0]{RO,SWRST:swrst,Link:handle.en}
		shadowarray_ben_t ben; //[1]{RO,SWRST:swrst,Link:beep.en}
		shadowarray_hben_t hben; //[2]{RO,SWRST:swrst,Link:[0]=handle.en,[1]=beep[0].en}
		//logic[28:0] resv0; //[31:3]
	} shadowarray_o_t; //INFO: 'h1004
	typedef struct {
		//logic[2:0] resv0; //[2:0]
		bicycleset_setset_t setset; //[30:3]{RO,SWRST:swrst,Link:bicycle.set}
		//logic resv1; //[31]
	} bicycleset_o_t; //INFO: 'h2004
	typedef struct {
		//logic[1:0] resv0; //[1:0]
		tricycle_tset_t tset; //[29:2]{RO,SWRST:tswrst,Link:bicycle.set}
		//logic[1:0] resv1; //[31:30]
	} tricycle_o_t; //INFO: 'h2008
	typedef struct {
		//logic resv0; //[0]
		google_beeponeen_t beeponeen; //[1]{RW,SWRST:swrst,Link:beep[1].en}
		google_handleen_t handleen; //[2]{RW,SWRST:swrst,EN:googleen,Link:handle.en}
		//logic[19:0] resv1; //[22:3]
		google_engine_t engine; //[24:23]{RW,SWRST:swrst,SelfClear,EN:enable}
		//logic[6:0] resv2; //[31:25]
	} google_o_t; //INFO: 'h200C
	typedef struct {
		writeone_clear_t clear; //[7:0]{W1C,SWRST:swrst}
		writeone_set_t set; //[15:8]{W1S,SWRST:swrst}
		//logic[15:0] resv0; //[31:16]
	} writeone_o_t; //INFO: 'h2010
	typedef struct {
		shadowwriteone_notclear_t notclear; //[7:0]{RW,SWRST:swrst,Link:writeone.set}
		shadowwriteone_notset_t notset; //[15:8]{RW,SWRST:swrst,Link:writeone.clear}
		//logic[15:0] resv0; //[31:16]
	} shadowwriteone_o_t; //INFO: 'h2014
	/*WO.registers*/
	typedef struct {
		//logic[15:0] resv0; //[15:0]
		beep_tone_t tone; //[16]{WO,SWRST:swrst,HardwareUpdate}
		//logic[14:0] resv1; //[31:17]
	} beep_wo_t; //INFO: 'h10
	typedef struct {
		//logic[3:0] resv0; //[3:0]
		beepsd_modet_t modet; //[7:4]{WO,SWRST:swrst,Link:beep.mode}
		//logic[23:0] resv1; //[31:8]
	} beepsd_wo_t; //INFO: 'h100
	typedef struct {
		//logic resv0; //[0]
		bicycle_set_t set; //[28:1]{WO,SelfClear}
		//logic[2:0] resv1; //[31:29]
	} bicycle_wo_t; //INFO: 'h2000
	/*I*/
	typedef struct {
		handle_i_t handle; //'h0
		beep_i_t beep[2]; //'h10+'h4*i
	} I_t;
	/*O*/
	typedef struct {
		handle_o_t handle; //'h0
		beep_o_t beep[2]; //'h10+'h4*i
		beepsd_o_t beepsd[2]; //'h100+'h10*i
		bigshadow_o_t bigshadow; //'h1000
		shadowarray_o_t shadowarray[2]; //'h1004+'h4*i
		bicycleset_o_t bicycleset; //'h2004
		tricycle_o_t tricycle; //'h2008
		google_o_t google; //'h200C
		writeone_o_t writeone; //'h2010
		shadowwriteone_o_t shadowwriteone; //'h2014
	} O_t;
	/*S*/
	typedef struct {
		logic[3:0] handle;
		logic[3:0] beep[2];
		logic[3:0] beepsd[2];
		logic[3:0] bicycle;
		logic[3:0] google;
		logic[3:0] writeone;
		logic[3:0] shadowwriteone;
		logic[31:0] data;
	} S_t;
	/*WO*/
	typedef struct {
		beep_wo_t beep[2]; //'h10+'h4*i
		beepsd_wo_t beepsd[2]; //'h100+'h10*i
		bicycle_wo_t bicycle; //'h2000
	} WO_t;
	/*Address/Offset*/
	localparam[31:0] GATE_BASE = 'h0;
	localparam[31:0] REG_GATE_HANDLE_OFFSET = GATE_BASE+'h0;
	localparam[31:0] REG_GATE_BEEP_OFFSET[2] = {GATE_BASE+'h10,GATE_BASE+'h14};
	localparam[31:0] REG_GATE_BEEPSD_OFFSET[2] = {GATE_BASE+'h100,GATE_BASE+'h110};
	localparam[31:0] REG_GATE_BIGSHADOW_OFFSET = GATE_BASE+'h1000;
	localparam[31:0] REG_GATE_SHADOWARRAY_OFFSET[2] = {GATE_BASE+'h1004,GATE_BASE+'h1008};
	localparam[31:0] REG_GATE_BICYCLE_OFFSET = GATE_BASE+'h2000;
	localparam[31:0] REG_GATE_BICYCLESET_OFFSET = GATE_BASE+'h2004;
	localparam[31:0] REG_GATE_TRICYCLE_OFFSET = GATE_BASE+'h2008;
	localparam[31:0] REG_GATE_GOOGLE_OFFSET = GATE_BASE+'h200C;
	localparam[31:0] REG_GATE_WRITEONE_OFFSET = GATE_BASE+'h2010;
	localparam[31:0] REG_GATE_SHADOWWRITEONE_OFFSET = GATE_BASE+'h2014;
	/*Default*/
	localparam FIELD_GATE_HANDLE_EN_RSTVAL = 1'h0;
	localparam FIELD_GATE_HANDLE_MODE_RSTVAL = 4'h0;
	localparam FIELD_GATE_HANDLE_STS0_RSTVAL = 10'h0;
	localparam FIELD_GATE_HANDLE_STS1_RSTVAL = 1'h0;
	localparam FIELD_GATE_BEEP_EN_RSTVAL = 1'h0;
	localparam FIELD_GATE_BEEP_MODE_RSTVAL = 4'h0;
	localparam FIELD_GATE_BEEP_TONE_RSTVAL = 1'h0;
	localparam FIELD_GATE_BEEPSD_MODES_RSTVAL = 4'h0;
	localparam FIELD_GATE_BEEPSD_MODET_RSTVAL = 4'h0;
	localparam FIELD_GATE_BEEPSD_MODER_RSTVAL = 4'h0;
	localparam FIELD_GATE_BIGSHADOW_HEN_RSTVAL = 1'h0;
	localparam FIELD_GATE_BIGSHADOW_BEN0_RSTVAL = 1'h0;
	localparam FIELD_GATE_BIGSHADOW_BEN1_RSTVAL = 1'h0;
	localparam FIELD_GATE_SHADOWARRAY_HEN_RSTVAL = 1'h0;
	localparam FIELD_GATE_SHADOWARRAY_BEN_RSTVAL = 1'h0;
	localparam FIELD_GATE_SHADOWARRAY_HBEN_RSTVAL = 1'h0;
	localparam FIELD_GATE_BICYCLE_SET_RSTVAL = 28'h0;
	localparam FIELD_GATE_BICYCLESET_SETSET_RSTVAL = 28'h0;
	localparam FIELD_GATE_TRICYCLE_TSET_RSTVAL = 28'h0;
	localparam FIELD_GATE_GOOGLE_BEEPONEEN_RSTVAL = 1'h0;
	localparam FIELD_GATE_GOOGLE_HANDLEEN_RSTVAL = 1'h0;
	localparam FIELD_GATE_GOOGLE_ENGINE_RSTVAL = 2'h0;
	localparam FIELD_GATE_WRITEONE_CLEAR_RSTVAL = 8'h0;
	localparam FIELD_GATE_WRITEONE_SET_RSTVAL = 8'h0;
	localparam FIELD_GATE_SHADOWWRITEONE_NOTCLEAR_RSTVAL = 8'h0;
	localparam FIELD_GATE_SHADOWWRITEONE_NOTSET_RSTVAL = 8'h0;
	/*shadows*/
	//beep[0].mode:
	//		beepsd[0].modes	beepsd[0].modet	beepsd[0].moder
	//beep[1].mode:
	//		beepsd[1].modes	beepsd[1].modet	beepsd[1].moder
	//handle.en:
	//		bigshadow.hen	shadowarray[0].hen	shadowarray[1].hen	shadowarray[0].hben	google.handleen
	//beep[0].en:
	//		bigshadow.ben0	shadowarray[0].ben	shadowarray[1].hben
	//beep[1].en:
	//		bigshadow.ben1	shadowarray[1].ben	google.beeponeen
	//bicycle.set:
	//		bicycleset.setset	tricycle.tset
	//writeone.set:
	//		shadowwriteone.notclear
	//writeone.clear:
	//		shadowwriteone.notset
endpackage: gate_reg_pkg
module gate_reg
import gate_reg_pkg::*;
#(
	 parameter AW=10 //TODO
	,parameter DW=32
	,localparam DB=DW/8 //bytewidth
)(
	 input logic i_clk
	,input logic i_rstn
	/*software reset or enable signals*/
	,input logic enbeep //enable bit
	,input logic googleen //enable bit
	,input logic enable //enable bit
	,input logic tswrst //software reset
	,input logic swrst //software reset
	,input logic[DB-1:0] i_wren
	,input logic[AW-1:0] i_wraddr
	,input logic[DW-1:0] i_wrdata
	,input logic[AW-1:0] i_rdaddr
	,output logic[DW-1:0] o_rddata_reg
	,output logic[DW-1:0] o_rddata_comb
	,input gate_reg_pkg::I_t I //all input fields and registers
	,output gate_reg_pkg::O_t O //all output fields and registers
	,output gate_reg_pkg::WO_t WO; //all 'WO' fields and registers
	,output gate_reg_pkg::S_t S //write enable signals and wdata
);
	logic[DW-1:0] rd_data;
	/*declare write enable signals*/
	logic[DB-1:0] wr_handle;
	logic[DB-1:0] wr_beep[2];
	logic[DB-1:0] wr_beepsd[2];
	logic[DB-1:0] wr_bicycle;
	logic[DB-1:0] wr_google;
	logic[DB-1:0] wr_writeone;
	logic[DB-1:0] wr_shadowwriteone;
	/*assign values to write enable signals*/
	assign S.data = i_wrdata;
	assign wr_handle = i_wren & {DB{i_wraddr[AW-1:2]==REG_GATE_HANDLE_OFFSET[AW-1:2]}}; //'h0
	assign S.handle = wr_handle;
	generate for(genvar wri=0; wri<2; wri++) begin: gen_wren_beep
		assign wr_beep[wri] = i_wren & {DB{i_wraddr[AW-1:2]==REG_GATE_BEEP_OFFSET[wri][AW-1:2]}}; //'h10+'h4*i
		assign S.beep[wri] = wr_beep[wri];
	end endgenerate //gen_wren_beep
	generate for(genvar wri=0; wri<2; wri++) begin: gen_wren_beepsd
		assign wr_beepsd[wri] = i_wren & {DB{i_wraddr[AW-1:2]==REG_GATE_BEEPSD_OFFSET[wri][AW-1:2]}}; //'h100+'h10*i
		assign S.beepsd[wri] = wr_beepsd[wri];
	end endgenerate //gen_wren_beepsd
	assign wr_bicycle = i_wren & {DB{i_wraddr[AW-1:2]==REG_GATE_BICYCLE_OFFSET[AW-1:2]}}; //'h2000
	assign S.bicycle = wr_bicycle;
	assign wr_google = i_wren & {DB{i_wraddr[AW-1:2]==REG_GATE_GOOGLE_OFFSET[AW-1:2]}}; //'h200C
	assign S.google = wr_google;
	assign wr_writeone = i_wren & {DB{i_wraddr[AW-1:2]==REG_GATE_WRITEONE_OFFSET[AW-1:2]}}; //'h2010
	assign S.writeone = wr_writeone;
	assign wr_shadowwriteone = i_wren & {DB{i_wraddr[AW-1:2]==REG_GATE_SHADOWWRITEONE_OFFSET[AW-1:2]}}; //'h2014
	assign S.shadowwriteone = wr_shadowwriteone;
	/*sequential logic*/
	//HANDLE::handler of gate
	/**/
	//EN::enable
	/**/
	//{RW,SWRST:swrst,HardwareUpdate}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(0), BitWidth(1)
		if(~i_rstn) begin
			O.handle.en.update <= 1'b1;
			O.handle.en.data <= FIELD_GATE_HANDLE_EN_RSTVAL; //1'h0
		end
		else if(swrst) begin //software reset
			O.handle.en.update <= 1'b1;
			O.handle.en.data <= FIELD_GATE_HANDLE_EN_RSTVAL; //1'h0
		end
		else if(I.handle.en.update) begin //hardware update
			O.handle.en.update <= 1'b1;
			O.handle.en.data <= I.handle.en.data;
		end
		else if(|wr_handle[0]) begin //software update
			O.handle.en.update <= 1'b1;
			O.handle.en.data <= wr_handle[0] ? i_wrdata[0]:O.handle.en.data;
		end
		//omit code //software reset from shadow [bigshadow.hen => handle.en]
		//omit code //software reset from shadow [shadowarray[0].hen => handle.en]
		//omit code //software reset from shadow [shadowarray[1].hen => handle.en]
		//omit code //software reset from shadow [shadowarray[0].hben => handle.en]
		//omit code //software reset from shadow [google.handleen => handle.en]
		else if(|wr_google[0]) begin //software update from shadow [google.handleen => handle.en]
			O.handle.en.update <= googleen;
			O.handle.en.data <= googleen&wr_google[0] ? i_wrdata[2]:O.handle.en.data;
		end
		else begin
			O.handle.en.update <= 1'b0;
		end
	end //always
	//HANDLE::handler of gate
	/**/
	//MODE::mode of handle
	/**/
	//{RW,SWRST:swrst}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(4), BitWidth(4)
		if(~i_rstn) begin
			O.handle.mode.update <= 1'b1;
			O.handle.mode.data <= FIELD_GATE_HANDLE_MODE_RSTVAL; //4'h0
		end
		else if(swrst) begin //software reset
			O.handle.mode.update <= 1'b1;
			O.handle.mode.data <= FIELD_GATE_HANDLE_MODE_RSTVAL; //4'h0
		end
		else if(|wr_handle[0]) begin //software update
			O.handle.mode.update <= 1'b1;
			O.handle.mode.data[3:0] <= wr_handle[0] ? i_wrdata[7:4]:O.handle.mode.data[3:0];
		end
		else begin
			O.handle.mode.update <= 1'b0;
		end
	end //always
	//HANDLE::handler of gate
	/**/
	//STS0::
	/**/
	//{RO,SWRST:swrst}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(16), BitWidth(10)
		if(~i_rstn) begin
			O.handle.sts0.update <= 1'b1;
			O.handle.sts0.data <= FIELD_GATE_HANDLE_STS0_RSTVAL; //10'h0
		end
		else if(swrst) begin //software reset
			O.handle.sts0.update <= 1'b1;
			O.handle.sts0.data <= FIELD_GATE_HANDLE_STS0_RSTVAL; //10'h0
		end
		else begin
			O.handle.sts0.update <= 1'b0;
		end
	end //always
	//BEEP::beeper of gate
	/**/
	generate for(genvar fi=0; fi<2; fi++) begin: gen_beep_en
	//EN::enable
	/**/
	//{RW}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(0), BitWidth(1)
		if(~i_rstn) begin
			O.beep[fi].en.update <= 1'b1;
			O.beep[fi].en.data <= FIELD_GATE_BEEP_EN_RSTVAL; //1'h0
		end
		else if(|wr_beep[fi][0]) begin //software update
			O.beep[fi].en.update <= 1'b1;
			O.beep[fi].en.data <= wr_beep[fi][0] ? i_wrdata[0]:O.beep[fi].en.data;
		end
		else if(swrst &&(fi==0)) begin //software reset from shadow [bigshadow.ben0 => beep[0].en]
			O.beep[fi].en.update <= 1'b1;
			O.beep[fi].en.data <= FIELD_GATE_BEEP_EN_RSTVAL; //1'h0
		end
		//omit code //software reset from shadow [shadowarray[0].ben => beep[0].en]
		//omit code //software reset from shadow [shadowarray[1].hben => beep[0].en]
		//omit code //software reset from shadow [bigshadow.ben1 => beep[1].en]
		//omit code //software reset from shadow [shadowarray[1].ben => beep[1].en]
		//omit code //software reset from shadow [google.beeponeen => beep[1].en]
		else if((|wr_google[0]) && (fi==1)) begin //software update from shadow [google.beeponeen => beep[1].en]
			O.beep[fi].en.update <= 1'b1;
			O.beep[fi].en.data <= wr_google[0] ? i_wrdata[1]:O.beep[1].en.data;
		end
		else begin
			O.beep[fi].en.update <= 1'b0;
		end
	end //always
	end endgenerate //gen_beep_en
	//BEEP::beeper of gate
	/**/
	generate for(genvar fi=0; fi<2; fi++) begin: gen_beep_mode
	//MODE::mode of handle
	/**/
	//{RW,SWRST:swrst,EN:enbeep}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(4), BitWidth(4)
		if(~i_rstn) begin
			O.beep[fi].mode.update <= 1'b1;
			O.beep[fi].mode.data <= FIELD_GATE_BEEP_MODE_RSTVAL; //4'h0
		end
		else if(swrst) begin //software reset
			O.beep[fi].mode.update <= 1'b1;
			O.beep[fi].mode.data <= FIELD_GATE_BEEP_MODE_RSTVAL; //4'h0
		end
		else if(|wr_beep[fi][0]) begin //software update
			O.beep[fi].mode.update <= enbeep;
			O.beep[fi].mode.data[3:0] <= enbeep&wr_beep[fi][0] ? i_wrdata[7:4]:O.beep[fi].mode.data[3:0];
		end
		//omit code //software reset from shadow [beepsd[0].modes => beep[0].mode]
		else if((|wr_beepsd[0][0]) && (fi==0)) begin //software update from shadow [beepsd[0].modes => beep[0].mode]
			O.beep[fi].mode.update <= 1'b1;
			O.beep[fi].mode.data[3:0] <= wr_beepsd[0][0] ? i_wrdata[3:0]:O.beep[0].mode.data[3:0];
		end
		//omit code //software reset from shadow [beepsd[0].modet => beep[0].mode]
		else if((|wr_beepsd[0][0]) && (fi==0)) begin //software update from shadow [beepsd[0].modet => beep[0].mode]
			O.beep[fi].mode.update <= 1'b1;
			O.beep[fi].mode.data[3:0] <= wr_beepsd[0][0] ? i_wrdata[7:4]:O.beep[0].mode.data[3:0];
		end
		//omit code //software reset from shadow [beepsd[0].moder => beep[0].mode]
		//omit code //software reset from shadow [beepsd[1].modes => beep[1].mode]
		else if((|wr_beepsd[1][0]) && (fi==1)) begin //software update from shadow [beepsd[1].modes => beep[1].mode]
			O.beep[fi].mode.update <= 1'b1;
			O.beep[fi].mode.data[3:0] <= wr_beepsd[1][0] ? i_wrdata[3:0]:O.beep[1].mode.data[3:0];
		end
		//omit code //software reset from shadow [beepsd[1].modet => beep[1].mode]
		else if((|wr_beepsd[1][0]) && (fi==1)) begin //software update from shadow [beepsd[1].modet => beep[1].mode]
			O.beep[fi].mode.update <= 1'b1;
			O.beep[fi].mode.data[3:0] <= wr_beepsd[1][0] ? i_wrdata[7:4]:O.beep[1].mode.data[3:0];
		end
		//omit code //software reset from shadow [beepsd[1].moder => beep[1].mode]
		else begin
			O.beep[fi].mode.update <= 1'b0;
		end
	end //always
	end endgenerate //gen_beep_mode
	//BEEP::beeper of gate
	/**/
	generate for(genvar fi=0; fi<2; fi++) begin: gen_beep_tone
	//TONE::
	/**/
	//{WO,SWRST:swrst,HardwareUpdate}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(16), BitWidth(1)
		if(~i_rstn) begin
			WO.beep[fi].tone.update <= 1'b1;
			WO.beep[fi].tone.data <= FIELD_GATE_BEEP_TONE_RSTVAL; //1'h0
		end
		else if(swrst) begin //software reset
			WO.beep[fi].tone.update <= 1'b1;
			WO.beep[fi].tone.data <= FIELD_GATE_BEEP_TONE_RSTVAL; //1'h0
		end
		else if(I.beep[fi].tone.update) begin //hardware update
			WO.beep[fi].tone.update <= 1'b1;
			WO.beep[fi].tone.data <= I.beep[fi].tone.data;
		end
		else if(|wr_beep[fi][2]) begin //software update
			WO.beep[fi].tone.update <= 1'b1;
			WO.beep[fi].tone.data <= wr_beep[fi][2] ? i_wrdata[16]:WO.beep[fi].tone.data;
		end
		else begin
			WO.beep[fi].tone.update <= 1'b0;
		end
	end //always
	end endgenerate //gen_beep_tone
	//BICYCLE::
	/**/
	//SET::
	/**/
	//{WO,SelfClear}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(1), BitWidth(28)
		if(~i_rstn) begin
			WO.bicycle.set.update <= 1'b1;
			WO.bicycle.set.data <= FIELD_GATE_BICYCLE_SET_RSTVAL; //28'h0
		end
		else if(|wr_bicycle[3:0]) begin //software update
			WO.bicycle.set.update <= 1'b1;
			WO.bicycle.set.data[6:0] <= wr_bicycle[0] ? i_wrdata[7:1]:WO.bicycle.set.data[6:0];
			WO.bicycle.set.data[14:7] <= wr_bicycle[1] ? i_wrdata[15:8]:WO.bicycle.set.data[14:7];
			WO.bicycle.set.data[22:15] <= wr_bicycle[2] ? i_wrdata[23:16]:WO.bicycle.set.data[22:15];
			WO.bicycle.set.data[27:23] <= wr_bicycle[3] ? i_wrdata[28:24]:WO.bicycle.set.data[27:23];
		end
		else if(swrst) begin //software reset from shadow [bicycleset.setset => bicycle.set]
			WO.bicycle.set.update <= 1'b1;
			WO.bicycle.set.data <= FIELD_GATE_BICYCLE_SET_RSTVAL; //28'h0
		end
		else if(tswrst) begin //software reset from shadow [tricycle.tset => bicycle.set]
			WO.bicycle.set.update <= 1'b1;
			WO.bicycle.set.data <= FIELD_GATE_BICYCLE_SET_RSTVAL; //28'h0
		end
		else begin
			WO.bicycle.set.update <= 1'b0;
			WO.bicycle.set.data <= 28'h0; //data is self cleared
		end
	end //always
	//GOOGLE::
	/**/
	//ENGINE::
	/**/
	//{RW,SWRST:swrst,SelfClear,EN:enable}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(23), BitWidth(2)
		if(~i_rstn) begin
			O.google.engine.update <= 1'b1;
			O.google.engine.data <= FIELD_GATE_GOOGLE_ENGINE_RSTVAL; //2'h0
		end
		else if(swrst) begin //software reset
			O.google.engine.update <= 1'b1;
			O.google.engine.data <= FIELD_GATE_GOOGLE_ENGINE_RSTVAL; //2'h0
		end
		else if(|wr_google[3:2]) begin //software update
			O.google.engine.update <= enable;
			O.google.engine.data[0] <= enable&wr_google[2] ? i_wrdata[23]:O.google.engine.data[0];
			O.google.engine.data[1] <= enable&wr_google[3] ? i_wrdata[24]:O.google.engine.data[1];
		end
		else begin
			O.google.engine.update <= 1'b0;
			O.google.engine.data <= 2'h0; //data is self cleared
		end
	end //always
	//WRITEONE::
	/**/
	//CLEAR::
	/**/
	//{W1C,SWRST:swrst}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(0), BitWidth(8)
		if(~i_rstn) begin
			O.writeone.clear.update <= 1'b1;
			O.writeone.clear.data <= FIELD_GATE_WRITEONE_CLEAR_RSTVAL; //8'h0
		end
		else if(swrst) begin //software reset
			O.writeone.clear.update <= 1'b1;
			O.writeone.clear.data <= FIELD_GATE_WRITEONE_CLEAR_RSTVAL; //8'h0
		end
		else if(|wr_writeone[0]) begin //software update
			O.writeone.clear.update <= 1'b1;
			O.writeone.clear.data[7:0] <= wr_writeone[0] ? ((~i_wrdata[7:0])&O.writeone.clear.data[7:0]):O.writeone.clear.data[7:0];
		end
		//omit code //software reset from shadow [shadowwriteone.notset => writeone.clear]
		else if(|wr_shadowwriteone[1]) begin //software update from shadow [shadowwriteone.notset => writeone.clear]
			O.writeone.clear.update <= 1'b1;
			O.writeone.clear.data[7:0] <= wr_shadowwriteone[1] ? i_wrdata[15:8]:O.writeone.clear.data[7:0];
		end
		else begin
			O.writeone.clear.update <= 1'b0;
		end
	end //always
	//WRITEONE::
	/**/
	//SET::
	/**/
	//{W1S,SWRST:swrst}
	always @ (posedge i_clk or negedge i_rstn) begin //StartBit(8), BitWidth(8)
		if(~i_rstn) begin
			O.writeone.set.update <= 1'b1;
			O.writeone.set.data <= FIELD_GATE_WRITEONE_SET_RSTVAL; //8'h0
		end
		else if(swrst) begin //software reset
			O.writeone.set.update <= 1'b1;
			O.writeone.set.data <= FIELD_GATE_WRITEONE_SET_RSTVAL; //8'h0
		end
		else if(|wr_writeone[1]) begin //software update
			O.writeone.set.update <= 1'b1;
			O.writeone.set.data[7:0] <= wr_writeone[1] ? (i_wrdata[15:8]|O.writeone.set.data[7:0]):O.writeone.set.data[7:0];
		end
		//omit code //software reset from shadow [shadowwriteone.notclear => writeone.set]
		else if(|wr_shadowwriteone[0]) begin //software update from shadow [shadowwriteone.notclear => writeone.set]
			O.writeone.set.update <= 1'b1;
			O.writeone.set.data[7:0] <= wr_shadowwriteone[0] ? i_wrdata[7:0]:O.writeone.set.data[7:0];
		end
		else begin
			O.writeone.set.update <= 1'b0;
		end
	end //always
	/*shadow fields*/
	assign O.beepsd[0].moder.data = O.beep[0].mode.data;
	assign O.beepsd[0].moder.update = O.beep[0].mode.update;
	assign O.beepsd[0].modes.data = O.beep[0].mode.data;
	assign O.beepsd[0].modes.update = O.beep[0].mode.update;
	assign O.beepsd[1].moder.data = O.beep[1].mode.data;
	assign O.beepsd[1].moder.update = O.beep[1].mode.update;
	assign O.beepsd[1].modes.data = O.beep[1].mode.data;
	assign O.beepsd[1].modes.update = O.beep[1].mode.update;
	assign O.bicycleset.setset.data = WO.bicycle.set.data;
	assign O.bicycleset.setset.update = WO.bicycle.set.update;
	assign O.bigshadow.ben0.data = O.beep[0].en.data;
	assign O.bigshadow.ben0.update = O.beep[0].en.update;
	assign O.bigshadow.ben1.data = O.beep[1].en.data;
	assign O.bigshadow.ben1.update = O.beep[1].en.update;
	assign O.bigshadow.hen.data = O.handle.en.data;
	assign O.bigshadow.hen.update = O.handle.en.update;
	assign O.google.beeponeen.data = O.beep[1].en.data;
	assign O.google.beeponeen.update = O.beep[1].en.update;
	assign O.google.handleen.data = O.handle.en.data;
	assign O.google.handleen.update = O.handle.en.update;
	assign O.shadowarray[0].ben.data = O.beep[0].en.data;
	assign O.shadowarray[0].ben.update = O.beep[0].en.update;
	assign O.shadowarray[0].hben.data = O.handle.en.data;
	assign O.shadowarray[0].hben.update = O.handle.en.update;
	assign O.shadowarray[0].hen.data = O.handle.en.data;
	assign O.shadowarray[0].hen.update = O.handle.en.update;
	assign O.shadowarray[1].ben.data = O.beep[1].en.data;
	assign O.shadowarray[1].ben.update = O.beep[1].en.update;
	assign O.shadowarray[1].hben.data = O.beep[0].en.data;
	assign O.shadowarray[1].hben.update = O.beep[0].en.update;
	assign O.shadowarray[1].hen.data = O.handle.en.data;
	assign O.shadowarray[1].hen.update = O.handle.en.update;
	assign O.shadowwriteone.notclear.data = O.writeone.set.data;
	assign O.shadowwriteone.notclear.update = O.writeone.set.update;
	assign O.shadowwriteone.notset.data = O.writeone.clear.data;
	assign O.shadowwriteone.notset.update = O.writeone.clear.update;
	assign O.tricycle.tset.data = WO.bicycle.set.data;
	assign O.tricycle.tset.update = WO.bicycle.set.update;
	assign WO.beepsd[0].modet.data = O.beep[0].mode.data;
	assign WO.beepsd[0].modet.update = O.beep[0].mode.update;
	assign WO.beepsd[1].modet.data = O.beep[1].mode.data;
	assign WO.beepsd[1].modet.update = O.beep[1].mode.update;
	always_comb begin
		rd_data = 32'h0;
		case(i_rdaddr[AW-1:2])
		/*combinational logic*/
		REG_GATE_HANDLE_OFFSET[AW-1:2]: begin
			rd_data[0] = O.handle.en.data;
			rd_data[7:4] = O.handle.mode.data;
			rd_data[25:16] = O.handle.sts0.data;
			rd_data[31] = I.handle.sts1.data;
			end
		REG_GATE_BEEP_OFFSET[0][AW-1:2]: begin
			rd_data[0] = O.beep[0].en.data;
			rd_data[7:4] = O.beep[0].mode.data;
			end
		REG_GATE_BEEP_OFFSET[1][AW-1:2]: begin
			rd_data[0] = O.beep[1].en.data;
			rd_data[7:4] = O.beep[1].mode.data;
			end
		REG_GATE_BEEPSD_OFFSET[0][AW-1:2]: begin
			rd_data[3:0] = O.beepsd[0].modes.data;
			rd_data[11:8] = O.beepsd[0].moder.data;
			end
		REG_GATE_BEEPSD_OFFSET[1][AW-1:2]: begin
			rd_data[3:0] = O.beepsd[1].modes.data;
			rd_data[11:8] = O.beepsd[1].moder.data;
			end
		REG_GATE_BIGSHADOW_OFFSET[AW-1:2]: begin
			rd_data[0] = O.bigshadow.hen.data;
			rd_data[1] = O.bigshadow.ben0.data;
			rd_data[2] = O.bigshadow.ben1.data;
			end
		REG_GATE_SHADOWARRAY_OFFSET[0][AW-1:2]: begin
			rd_data[0] = O.shadowarray[0].hen.data;
			rd_data[1] = O.shadowarray[0].ben.data;
			rd_data[2] = O.shadowarray[0].hben.data;
			end
		REG_GATE_SHADOWARRAY_OFFSET[1][AW-1:2]: begin
			rd_data[0] = O.shadowarray[1].hen.data;
			rd_data[1] = O.shadowarray[1].ben.data;
			rd_data[2] = O.shadowarray[1].hben.data;
			end
		REG_GATE_BICYCLE_OFFSET[AW-1:2]: begin
			end
		REG_GATE_BICYCLESET_OFFSET[AW-1:2]: begin
			rd_data[30:3] = O.bicycleset.setset.data;
			end
		REG_GATE_TRICYCLE_OFFSET[AW-1:2]: begin
			rd_data[29:2] = O.tricycle.tset.data;
			end
		REG_GATE_GOOGLE_OFFSET[AW-1:2]: begin
			rd_data[1] = O.google.beeponeen.data;
			rd_data[2] = O.google.handleen.data;
			rd_data[24:23] = O.google.engine.data;
			end
		REG_GATE_WRITEONE_OFFSET[AW-1:2]: begin
			rd_data[7:0] = O.writeone.clear.data;
			rd_data[15:8] = O.writeone.set.data;
			end
		REG_GATE_SHADOWWRITEONE_OFFSET[AW-1:2]: begin
			rd_data[7:0] = O.shadowwriteone.notclear.data;
			rd_data[15:8] = O.shadowwriteone.notset.data;
			end
		default: rd_data = 32'h0;
		endcase
	end
	assign o_rdata_comb = rd_data;
	always @ (posedge i_clk or negedge i_rstn) begin
		if(~i_rstn) o_rddata_reg <= 'h0;
		else o_rddata_reg <= rd_data;
	end
endmodule
