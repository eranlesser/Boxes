package com.utils
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;

	public class AssetsManager{
		public var complete:Signal;
		
		private var _assets:XML = new XML(
			"<assets>" +
			
			//SCRREN1
			"<image path='assets/scene_1/F1_BOXES_1024x768_bg1.jpg' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_bg2.jpg' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_bg3.jpg' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_bg4.jpg' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_bg5.jpg' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_bg6.jpg' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_bg7.jpg' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_front1.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_front2.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_front3.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_front4.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_front5.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_front6.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_front7.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_smoke_particle.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_subtitle_x191_y679.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_cat_x158_y443.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_hotspot_cat_x98_y125.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_hotspot_win_x730_y228.png' />"+
			"<image path='assets/scene_1/F1_BOXES_1024x768_peep_x799_y247.png' />"+
			//SCENE_2
			
			"<image path='assets/scene_2/F2_1024x768_background.jpg' />"+
			"<image path='assets/scene_2/F2_1024x768_cat_body_x-319_y330.png' />"+
			"<image path='assets/scene_2/F2_1024x768_cat_tail_x-388_y395.png' />"+
			"<image path='assets/scene_2/F2_1024x768_man_upper_x-88_y230.png' />"+
			"<image path='assets/scene_2/F2_1024x768_man_bottom_x-158_y324.png' />"+
			
			//SCENE_4
			"<image path='assets/scene_4/F4_1024x768_buildings_back_x0_y117.png' />"+
			"<image path='assets/scene_4/F4_1024x768_buildings_front_x0_y0.png' />"+
			"<image path='assets/scene_4/F4_1024x768_moon_x70_y-316.png' />"+
			"<image path='assets/scene_4/F4_1024x768_sky_x0_y-386.png' />"+
			"<image path='assets/scene_4/F4_1024x768_sun_x70_y644.png' />"+
			"<image path='assets/scene_4/Text_F4_1024x768_x666_y240.png' />"+
			//SCENE_6
			"<image path='assets/scene_6/F6_1024x768_background.jpg' />"+
			"<image path='assets/scene_6/F6_1024x768_cat0_x440_y493.png' />"+
			"<image path='assets/scene_6/F6_1024x768_cat1_x440_y493.png' />"+
			"<image path='assets/scene_6/F6_1024x768_cat2_x440_y493.png' />"+
			"<image path='assets/scene_6/F6_1024x768_cat3_x440_y493.png' />"+
			"<image path='assets/scene_6/F6_1024x768_cat4_x440_y493.png' />"+
			"<image path='assets/scene_6/F6_1024x768_man_above_x387_y299.png' />"+
			"<image path='assets/scene_6/F6_1024x768_bang_x329_y322.png' />"+
			"<image path='assets/scene_6/F6_1024x768_hotspot_x379_y310.png' />"+
			"<image path='assets/scene_6/Text_F6_1024x768_x139_y150.png' />"+
			//SCENE_7
			"<image path='assets/scene_7/F7_1024x768_back_image.jpg' />"+
			"<image path='assets/scene_7/F7_1024x768_bang_drawer_x635_y130.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bang_shower_x326_y524.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bang_tap_x300_y230.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble1.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble2.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble3.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble4.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble5.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble6.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble7.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble8.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble9.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble10.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble11.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble12.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble13.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble14.png' />"+
			"<image path='assets/scene_7/F7_1024x768_bubble15.png' />"+
			"<image path='assets/scene_7/F7_1024x768_hotspot_lower_left_x0_y418.png' />"+
			"<image path='assets/scene_7/F7_1024x768_hotspot_lower_right_x516_y418.png' />"+
			"<image path='assets/scene_7/F7_1024x768_hotspot_upper_left_x0_y0.png' />"+
			"<image path='assets/scene_7/F7_1024x768_hotspot_upper_mid_x507_y0.png' />"+
			"<image path='assets/scene_7/F7_1024x768_mouth_x751_y693.png' />"+
			"<image path='assets/scene_7/F7_1024x768_shower_mask_x58_y369.png' />"+
			"<image path='assets/scene_7/F7_1024x768_shower1_x347_y453.png' />"+
			"<image path='assets/scene_7/F7_1024x768_shower2_x347_y453.png' />"+
			"<image path='assets/scene_7/F7_1024x768_shower3_x347_y453.png' />"+
			"<image path='assets/scene_7/F7_1024x768_water1_x345_y147.png' />"+
			"<image path='assets/scene_7/F7_1024x768_water2_x345_y147.png' />"+
			"<image path='assets/scene_7/F7_1024x768_water3_x345_y147.png' />"+
			"<image path='assets/scene_7/F7_1024x768_hotspot_cat_x528_y248.png' />"+
			"<image path='assets/scene_7/Text1_F7_1024x768_x35_y29.png' />"+
			"<image path='assets/scene_7/Text2_F7_1024x768_x552_y229.png' />"+
			"<image path='assets/scene_7/Text3_F7_1024x768_x121_y657.png' />"+
			"<image path='assets/scene_7/Text4_F7_1024x768_x602_y387.png' />"+
			//SCENE_8
			"<image path='assets/scene_8/F8_1024x768_background_1.jpg' />"+
			"<image path='assets/scene_8/F8_1024x768_background_2.jpg' />"+
			"<image path='assets/scene_8/F8_1024x768_background_3.jpg' />"+
			"<image path='assets/scene_8/F8_1024x768_bell.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_bird.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_bluebird.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_boat.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_bottle.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_bubles.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_bulb.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_cat.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_dish.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_dog.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_eye.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_fish.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_flower.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_hat.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_heart.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_key.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_lightning.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_mouse.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_omlet.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_paw.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_plant.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_roach.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_star.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_string.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_window.PNG' />"+
			"<image path='assets/scene_8/F8_1024x768_hotspot_x321_y28.PNG' />"+
			"<image path='assets/scene_8/Text_F8_1024x768_x59_y265.PNG' />"+
			//SCENE_9
			"<image path='assets/scene_9/F9_1024x768_background.jpg' />"+
			"<image path='assets/scene_9/F9_1024x768_buslights_x-428_y264.png' />"+
			"<image path='assets/scene_9/F9_1024x768_buslights_flicker_x543_y308.png' />"+
			"<image path='assets/scene_9/F9_1024x768_hotspot_light1_x532_y315.png' />"+
			"<image path='assets/scene_9/F9_1024x768_hotspot_light2_x835_y297.png' />"+
			"<image path='assets/scene_9/F9_1024x768_hotspot_plates_x612_y311.png' />"+
			"<image path='assets/scene_9/Text1_F9_1024x768_x62_y558.png' />"+
			"<image path='assets/scene_9/Text2_F9_1024x768_x568_y447.png' />"+
			
			"<image path='assets/scene_9/dogs/F9_1024x768_bigdog_hotspot_x585_y142.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_bigdog1_x544_y127.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_bigdog2_x544_y127.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_bigdog3_x544_y127.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_bigdog4_x544_y127.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_pig_hotspot_x393_y159.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_pig1_x383_y139.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_pig2_x383_y139.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_smldog_hotspot_x477_y158.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_smldog1_x468_y144.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_smldog2_x468_y144.png' />"+
			"<image path='assets/scene_9/dogs/F9_1024x768_smldog3_xx468_y144.png' />"+
			
			//SCENE_10
			"<image path='assets/scene_10/F10_1024x768_bus_bg_x0_y40.jpg' />"+
			"<image path='assets/scene_10/F10_1024x768_inside_bus_x-30_y-37.png' />"+
			"<image path='assets/scene_10/F10_1024x768_bag_x739_y27.png' />"+
			"<image path='assets/scene_10/Text_box_open_hotspot_F10_1024x768_x85_y463.png' />"+
			"<image path='assets/scene_10/Text_box_F10_1024x768_x85_y463.png' />"+
			"<image path='assets/scene_10/Text1_F10_1024x768_x128_y507.png' />"+
			"<image path='assets/scene_10/Text2_F10_1024x768_x128_y507.png' />"+
			
			//SCENE_11
			"<image path='assets/scene_11/F11_1024x768_button_glow_x317_y580.png' />"+
			"<image path='assets/scene_11/F11_1024x768_elevator_x106_y145.jpg' />"+
			"<image path='assets/scene_11/F11_1024x768_left_lower_win_closed_x989_y437.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_left_lower_win_open_x828_y396.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_left_upper_win_closed_x948_y72.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_left_upper_win_open_x817_y16.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_light_x952_y76.jpg' />"+
			"<image path='assets/scene_11/F11_1024x768_paper_drop_x1590_y48.jpg' />"+
			"<image path='assets/scene_11/F11_1024x768_right_lower_win_closed_x1405_y470.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_right_lower_win_open_x1406_y471.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_right_upper_win_closed_x1473_y27.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_right_upper_win_open_x1394_y27.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_smoke_particle.png' />"+
			"<image path='assets/scene_11/F11_1024x768_windows_BG_x775_y0.jpg' />"+
			"<image path='assets/scene_11/F11_1024x768_button_hotspot_x300_y563.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_left_lower_win_hotspot_x989_y437.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_left_upper_win_hotspot_x948_y72.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_right_upper_win_hotspot_x1473_y27.PNG' />"+
			"<image path='assets/scene_11/F11_1024x768_right_lower_win_hotspot_x1405_y470.PNG' />"+
			"<image path='assets/scene_11/Text1_F11_1024x768_x511_y146.png' />"+
			"<image path='assets/scene_11/Text2_F11_1024x768_x1744_y395.png' />"+
			"<image path='assets/scene_11/Text3_F11_1024x768_x1270_y414.png' />"+
			"<image path='assets/scene_11/Text4_F11_1024x768_x1166_y39.png' />"+
			"<image path='assets/scene_11/Text5_F11_1024x768_x1257_y714.png' />"+
			"<image path='assets/scene_11/Text6_F11_1024x768_x1708_y650.png' />"+
			"<image path='assets/scene_11/F11_1024x768_button_hotspot_x106_y142.PNG' />"+
			//SCENE_13
			"<image path='assets/scene_13/F13_1024x768_background.jpg' />"+
			"<image path='assets/scene_13/F13_1024x768_manstand_x217_y317.png' />"+
			"<image path='assets/scene_13/F13_1024x768_manwalk_x316_y428.png' />"+
			"<image path='assets/scene_13/Text_box_F13_1024x768_x15_y16.png' />"+
			"<image path='assets/scene_13/Text_box_open_hotspot_F13_1024x768_x15_y16.png' />"+
			"<image path='assets/scene_13/Text_F13_1024x768_x523_y511.png' />"+
			
			//SCENE_14
			"<image path='assets/scene_14/F14_1024x768_character1_x670_y39.png' />"+
			"<image path='assets/scene_14/F14_1024x768_character2_x238_y-252.png' />"+
			"<image path='assets/scene_14/F14_1024x768_character3_x-146_y354.png' />"+
			"<image path='assets/scene_14/F14_1024x768_character4_x142_y-145.png' />"+
			"<image path='assets/scene_14/F14_1024x768_character5_x709_y-36.png' />"+
			"<image path='assets/scene_14/F14_1024x768_character6_x-112_y-152.png' />"+
			"<image path='assets/scene_14/F14_1024x768_character7_x64_y93.png' />"+
			"<image path='assets/scene_14/F14_1024x768_character10_x4_y-92.png' />"+
			"<image path='assets/scene_14/F14_1024x768_character11_x663_y-146.png' />"+
			"<image path='assets/scene_14/F14_1024x768_background.jpg' />"+
			"<image path='assets/scene_14/F14_1024x768_man_x591_y117.png' />"+
			"<image path='assets/scene_14/Text_F14_1024x768_x290_y301.png' />"+

			//SCENE_14
			"<image path='assets/scene_6/Text_F15_1024x768_x139_y151.PNG' />"+
			//SCENE_16
			"<image path='assets/scene_16/F16_1024x768_background.jpg' />"+
			"<image path='assets/scene_16/F16_1024x768_bang_hotspot_x126_y0.png' />"+
			"<image path='assets/scene_16/F16_1024x768_bang_x313_y166.png' />"+
			"<image path='assets/scene_16/F16_1024x768_bird_hotspot_x392_y372.png' />"+
			"<image path='assets/scene_16/F16_1024x768_bird_x392_y372.png' />"+
			"<image path='assets/scene_16/F16_1024x768_cat_door_hotspot_x0_y106.png' />"+
			"<image path='assets/scene_16/F16_1024x768_cat_door_x0_y106.jpg' />"+
			"<image path='assets/scene_16/F16_1024x768_cat_drink_hotspot_x0_y375.png' />"+
			"<image path='assets/scene_16/F16_1024x768_cat_drink_x280_y482.jpg' />"+
			"<image path='assets/scene_16/F16_1024x768_door_hotspot_x562_y210.png' />"+
			"<image path='assets/scene_16/F16_1024x768_door_x552_y198.png' />"+
			"<image path='assets/scene_16/Text_F16_1024x768_x36_y341.png' />"+
			"<image path='assets/scene_16/F16_1024x768_popup_x0_y0.png' />"+
			//SCENE_17
			"<image path='assets/scene_17/F17_1024x768_background.jpg' />"+
			"<image path='assets/scene_17/F17_1024x768_boat.png' />"+
			"<image path='assets/scene_17/F17_1024x768_foreground.png' />"+
			"<image path='assets/scene_17/Text_F17_1024x768_x34_y481.png' />"+
			//SCENE_18
			"<image path='assets/scene_18/F18_1024x768_background.jpg' />"+
			"<image path='assets/scene_18/F18_1024x768_diver_hotspot_x940_y280.png' />"+
			"<image path='assets/scene_18/F18_1024x768_diver_mask_x918_y361.png' />"+
			"<image path='assets/scene_18/F18_1024x768_diver_x940_y320.png' />"+
			"<image path='assets/scene_18/F18_1024x768_legs_hotspot_x919_y510.png' />"+
			"<image path='assets/scene_18/F18_1024x768_legs_x891_y506.png' />"+
			"<image path='assets/scene_18/F18_1024x768_man1_hotspot_x616_y355.png' />"+
			"<image path='assets/scene_18/F18_1024x768_man1_x610_y293.png' />"+
			"<image path='assets/scene_18/F18_1024x768_man2_hotspot1_x661_y0.png' />"+
			"<image path='assets/scene_18/F18_1024x768_man2_hotspot2_x795_y278.png' />"+
			"<image path='assets/scene_18/F18_1024x768_man2_x656_y0.png' />"+
			"<image path='assets/scene_18/F18_1024x768_man3_hotspot_x199_y403.png' />"+
			"<image path='assets/scene_18/F18_1024x768_man3_x65_y355.png' />"+
			"<image path='assets/scene_18/F18_1024x768_woman1_hotspot_x0_y0.png' />"+
			"<image path='assets/scene_18/F18_1024x768_woman1_x0_y10.png' />"+
			"<image path='assets/scene_18/F18_1024x768_woman2_hotspot_x313_y37.png' />"+
			"<image path='assets/scene_18/F18_1024x768_woman2_x307_y38.png' />"+
			"<image path='assets/scene_18/Text_F18_1024x768_x212_y671.png' />"+
			
			//SCENE_19
			"<image path='assets/scene_19/F19_1024x768_background.jpg' />"+
			"<image path='assets/scene_19/F19_1024x768_drops_x0_y519.png' />"+
			"<image path='assets/scene_19/F19_1024x768_man_after_x473_y237.png' />"+
			"<image path='assets/scene_19/F19_1024x768_man_hotspot_x493_y255.png' />"+
			"<image path='assets/scene_19/F19_1024x768_man_reg_x479_y237.png' />"+
			"<image path='assets/scene_19/F19_1024x768_sea_x0_y528.png' />"+
			"<image path='assets/scene_19/Text_Box_F19_1024x768_x15_y16.png' />"+
			"<image path='assets/scene_19/Text_box_open_hotspot_F19_1024x768_x15_y16.png' />"+
			"<image path='assets/scene_19/Text_F19_1024x768_x49_y50.png' />"+
			
			//SCENE_20
			"<image path='assets/scene_20/F20_1024x768_climb_hotspot_x553_y663.png' />"+
			"<image path='assets/scene_20/F20_1024x768_climb2_x538_y621.png' />"+
			"<image path='assets/scene_20/F20_1024x768_climb3_x538_y621.png' />"+
			"<image path='assets/scene_20/F20_1024x768_climb4_x538_y621.png' />"+
			"<image path='assets/scene_20/F20_1024x768_climb5_x538_y621.png' />"+
			"<image path='assets/scene_20/F20_1024x768_climb6_x538_y621.png' />"+
			"<image path='assets/scene_20/F20_1024x768_climb7_x538_y621.png' />"+
			"<image path='assets/scene_20/F20_1024x768_climb8_x538_y621.png' />"+
			"<image path='assets/scene_20/F20_1024x768_laddar_x496_y-28.png' />"+
			"<image path='assets/scene_20/Text_F20_1024x768_x56_y357.png' />"+
			//SCENE_21
			"<image path='assets/scene_21/F21_1024x768_background.jpg' />"+
			"<image path='assets/scene_21/F21_1024x768_big_megaphone_x765_y257.jpg' />"+
			"<image path='assets/scene_21/F21_1024x768_man_window_x526_y220.jpg' />"+
			"<image path='assets/scene_21/Text_F21_1024x768_x172_y438.png' />"+
			//SCENE_22
			"<image path='assets/scene_22/F22_1024x768_background1.jpg' />"+
			"<image path='assets/scene_22/F22_1024x768_background2.jpg' />"+
			"<image path='assets/scene_22/F22_1024x768_background3.jpg' />"+
			"<image path='assets/scene_22/F22_1024x768_hotspot_x420_y61.png' />"+
			"<image path='assets/scene_22/Text_F22_1024x768_x74_y415.png' />"+
			//SCENE_23
			"<image path='assets/scene_23/F23_1024x768_back.jpg' />"+
			"<image path='assets/scene_23/F23_1024x768_face1_x14_y459.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_face2_x126_y80.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_face3_x440_y255.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_face4_x683_y38.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_face5_x857_y275.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_face6_x893_y378.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_hotspot1_x0_y409.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_hotspot2_x119_y21.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_hotspot3_x381_y240.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_hotspot4_x606_y1.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_hotspot5_x812_y230.PNG' />"+
			"<image path='assets/scene_23/F23_1024x768_hotspot6_x865_y426.PNG' />"+
			"<image path='assets/scene_23/Text_box_F23_1024x768_x249_y529.PNG' />"+
			"<image path='assets/scene_23/Text_box_open_hotspot_F23_1024x768_x249_y529.png' />"+
			"<image path='assets/scene_23/Text_F23_1024x768_x292_y562.PNG' />"+
			//SCENE_24
			"<image path='assets/scene_24/F24_1024x768_background_sky.jpg' />"+
			"<image path='assets/scene_24/F24_1024x768_ballon_x184_y523.png' />"+
			"<image path='assets/scene_24/F24_1024x768_sea_x0_y520.png' />"+
			"<image path='assets/scene_24/Text_F24_1024x768_x306_y206.png' />"+
			//SCENE_25
			"<image path='assets/scene_25/F25_1024x768_background.jpg' />"+
			"<image path='assets/scene_25/F25_1024x768_people.png' />"+
			"<image path='assets/scene_25/F25_1024x768_lines_x274_y33.png' />"+
			"<image path='assets/scene_25/F25_1024x768_ballon_x274_y33.png' />"+
			"<image path='assets/scene_25/Text_F25_1024x768_x59_y380.png' />"+
			
			//SCENE_26
			"<image path='assets/scene_26/F26_1024x768_background.jpg' />"+
			"<image path='assets/scene_26/F26_1024x768_baloon_x479_y239.png' />"+
			"<image path='assets/scene_26/F26_1024x768_beach_x0_y597.png' />"+
			"<image path='assets/scene_26/F26_1024x768_man_x343_y342.png' />"+
			"<image path='assets/scene_26/F26_1024x768_people_x0_y281.png' />"+
			"<image path='assets/scene_26/F26_1024x768_sea_x0_y399.png' />"+
			"<image path='assets/scene_26/Text_F26_1024x768_x58_y60.png' />"+
			//SCENE_27
			"<image path='assets/scene_27/F27_1024x768_background.jpg' />"+
			"<image path='assets/scene_27/F27_1024x768_baloon_hotspot_x187_y-304.png' />"+
			"<image path='assets/scene_27/F27_1024x768_baloon_x187_y-304.png' />"+
			"<image path='assets/scene_27/F27_1024x768_clouds_x-403_y132.png' />"+
			"<image path='assets/scene_27/F27_1024x768_fire1_x397_y342.png' />"+
			"<image path='assets/scene_27/F27_1024x768_fire2_x397_y342.png' />"+
			"<image path='assets/scene_27/F27_1024x768_fire3_x397_y342.png' />"+
			"<image path='assets/scene_27/F27_1024x768_firebucket_x496_y391.png' />"+
			"<image path='assets/scene_27/F27_1024x768_sea_x0_y674.png' />"+
			"<image path='assets/scene_27/Text_F27_1024x768_x315_y101.png' />"+
			//SCENE_28
			"<image path='assets/scene_28/F28_1024x768_ballon_x200_y151.png' />"+
			"<image path='assets/scene_28/F28_1024x768_clouds_x-356_y141.png' />"+
			"<image path='assets/scene_28/F28_1024x768_sea_x0_y606.png' />"+
			"<image path='assets/scene_28/Text_F28_1024x768_x60_y60.png' />"+
			//SCENE_29
			"<image path='assets/scene_29/F29_1024x768_ballon_x-50_y236.png' />"+
			"<image path='assets/scene_29/F29_1024x768_bird1.png' />"+
			"<image path='assets/scene_29/F29_1024x768_bird2.png' />"+
			"<image path='assets/scene_29/F29_1024x768_bird3.png' />"+
			"<image path='assets/scene_29/F29_1024x768_cloud1_x-500_y79.png' />"+
			"<image path='assets/scene_29/F29_1024x768_cloud2_x-564_y466.png' />"+
			"<image path='assets/scene_29/Text_F29_1024x768_x60_y60.png' />"+
			"<image path='assets/scene_29/F29_1024x768_hat_x221_y586.png' />"+
			//SCENE_30
			"<image path='assets/scene_30/F30_1024x768_background.jpg' />"+
			"<image path='assets/scene_30/F30_1024x768_ballon_x-43_y207.png' />"+
			"<image path='assets/scene_30/Text_F30_1024x768_x61_y60.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00009.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00010.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00011.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00012.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00013.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00014.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00015.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00016.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00017.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00018.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00019.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00020.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00021.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00022.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00023.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00024.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00025.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00026.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00027.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00028.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00029.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00030.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00031.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00032.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00033.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00034.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00035.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00036.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00037.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00038.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00039.png' />"+
			"<image path='assets/scene_30/text_anim/Bye-bye!-F30_1024x768_00040.png' />"+
			//SCENE_31
			"<image path='assets/scene_31/F31_1024x768_background.jpg' />"+
			"<image path='assets/scene_31/F31_1024x768_ballon_x251_y299.png' />"+
			"<image path='assets/scene_31/F31_1024x768_city_x0_y464.png' />"+
			"<image path='assets/scene_31/Text_F31_1024x772_x0_y56.png' />"+
			//SCENE_31b
			"<image path='assets/scene_31b/F31_5_1024x768_BG.jpg' />"+
			"<image path='assets/scene_31b/F31_5_1024x768_mouth_x618_y506.png' />"+
			
			//SCENE_32
			"<image path='assets/scene_32/F32_1024x768_x-4500_y0.jpg' />"+
			//			CREDITS
			//			"<image path='assets/scene_14/F14_1024x768_big_dog_hotspot_x306_y616.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_big_dog_rest_x250_y604.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_big_dog_wig1_x250_y604.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_big_dog_wig2_x250_y604.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_big_dog_wig3_x250_y604.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_character8_x-17_y-209.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_character9_x672_y-28.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_pig_hotspot_x38_y640.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_pig1_x26_y626.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_pig2_x26_y626.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_sml_dog_hotspot_x155_y639.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_sml_dog_rest_x145_y626.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_sml_dog_wig1_x145_y626.png' />"+
			//			"<image path='assets/scene_14/F14_1024x768_sml_dog_wig2_x145_y626.png' />"+
			//GUI
			"<image path='assets/gui/arrow_left_colorBG_x5_y696.png' />"+
			"<image path='assets/gui/arrow_left_hotspot_x5_y696.png' />"+
			"<image path='assets/gui/arrow_left_whiteBG_x5_y696.png' />"+
			"<image path='assets/gui/arrow_right_colorBG_x952_y696.png' />"+
			"<image path='assets/gui/arrow_right_hotspot_x952_y696.png' />"+
			"<image path='assets/gui/arrow_right_whiteBG_x952_y696.png' />"+
			"<image path='assets/gui/settings_whiteBG_x460_y730.png' />"+
			"<image path='assets/gui/settings_colorBG_x460_y730.png' />"+
			"<image path='assets/gui/settings_hotspot_x460_y730.png' />"+
			//MENU
			"<image path='assets/menu/scene_menu_about_hotspot_x573_y363.png' />"+
			"<image path='assets/menu/scene_menu_background.png' />"+
			"<image path='assets/menu/scene_menu_down_hotspot_x457_y731.png' />"+
			"<image path='assets/menu/scene_menu_home_hotspot_x822_y490.png' />"+
			"<image path='assets/menu/scene_menu_pages_hotspot_x323_y548.png' />"+
			"<image path='assets/menu/scene_menu_reading_options_hotspot_x102_y365.png' />"+
			"<image path='assets/menu/scene_menu_tell_a_friend_hotspot_x489_y556.png' />"+
			"<image path='assets/menu/scene_menu_text_narration_hotspot_x51_y581.png' />"+
			"<image path='assets/menu/scene_menu_x0_y768.png' />"+
			"<image path='assets/menu/read_mode_readbymyself_hotspot_x532_y-227.png' />"+
			"<image path='assets/menu/read_mode_readbymyself_x318_y-327.png' />"+
			"<image path='assets/menu/read_mode_readtome_x318_y-327.png' />"+
			"<image path='assets/menu/read_mode_readtomef_hotspot_x353_y-227.png' />"+
			"<image path='assets/menu/read_mode_up_hotspot_x466_y-261.png' />"+
			//naration options
			"<image path='assets/menu/text_narrate_toff_noff_x318_y-327.png' />"+
			"<image path='assets/menu/text_narrate_toff_non_x318_y-327.png' />"+
			"<image path='assets/menu/text_narrate_ton_noff_x318_y-327.png' />"+
			"<image path='assets/menu/text_narrate_ton_non_x318_y-327.png' />"+
			//Scenes Menu
			"<image path='assets/menu/pages_strip_x0_y768.png' />"+
			"<image path='assets/menu/scene_thumbs/1.jpg' />"+
			"<image path='assets/menu/scene_thumbs/2.jpg' />"+
			"<image path='assets/menu/scene_thumbs/3.jpg' />"+
			"<image path='assets/menu/scene_thumbs/4.jpg' />"+
			"<image path='assets/menu/scene_thumbs/5.jpg' />"+
			"<image path='assets/menu/scene_thumbs/6.jpg' />"+
			"<image path='assets/menu/scene_thumbs/7.jpg' />"+
			"<image path='assets/menu/scene_thumbs/8.jpg' />"+
			"<image path='assets/menu/scene_thumbs/9.jpg' />"+
			"<image path='assets/menu/scene_thumbs/10.jpg' />"+
			"<image path='assets/menu/scene_thumbs/11.jpg' />"+
			"<image path='assets/menu/scene_thumbs/12.jpg' />"+
			"<image path='assets/menu/scene_thumbs/13.jpg' />"+
			"<image path='assets/menu/scene_thumbs/14.jpg' />"+
			"<image path='assets/menu/scene_thumbs/15.jpg' />"+
			"<image path='assets/menu/scene_thumbs/16.jpg' />"+
			"<image path='assets/menu/scene_thumbs/17.jpg' />"+
			"<image path='assets/menu/scene_thumbs/18.jpg' />"+
			"<image path='assets/menu/scene_thumbs/19.jpg' />"+
			"<image path='assets/menu/scene_thumbs/20.jpg' />"+
			"<image path='assets/menu/scene_thumbs/21.jpg' />"+
			"<image path='assets/menu/scene_thumbs/22.jpg' />"+
			"<image path='assets/menu/scene_thumbs/23.jpg' />"+
			"<image path='assets/menu/scene_thumbs/24.jpg' />"+
			"<image path='assets/menu/scene_thumbs/25.jpg' />"+
			"<image path='assets/menu/scene_thumbs/26.jpg' />"+
			"<image path='assets/menu/scene_thumbs/27.jpg' />"+
			//about
			"<image path='assets/menu/about/about_close_hotspot_x466_y-704.png' />"+
			"<image path='assets/menu/about/about_darker_BG_x0_y0.png' />"+
			"<image path='assets/menu/about/about_eran_site_hotspot_x542_y-564.png' />"+
			"<image path='assets/menu/about/about_image_x38_y-709.png' />"+
			"<image path='assets/menu/about/about_katz_hotspot_x70_y-181.png' />"+
			"<image path='assets/menu/about/about_libby_hotspot_x542_y-78.png' />"+
			"<image path='assets/menu/about/about_liora_hotspot_x258_y-524.png' />"+
			"<image path='assets/menu/about/about_liora_site_hotspot_x70_y-524.png' />"+
			"<image path='assets/menu/about/about_sharon_hotspot_x542_y-378.png' />"+
			"<image path='assets/menu/about/about_yaira_hotspot_x542_y-230.png' />"+
			"<image path='assets/menu/about/about_yoran_hotspot_x70_y-352.png' />"+
			//home
			"<image path='assets/open_menu/Open_Menu_1024x768_BG.jpg' />"+
			"<image path='assets/open_menu/Open_Menu_1024x768_readbymyself_hotspot_x551_y239.png' />"+
			"<image path='assets/open_menu/Open_Menu_1024x768_readtome_hotspot_x138_y239.png' />"+
			//touchhere
			"<image path='assets/gui/touch_here_bright.png' />"+
			"<image path='assets/gui/touch_here_dark.png' />"+
			
			//video
			
			"<image path='assets/gui/video/home_icon_x5_y696.png' />"+
			"<image path='assets/gui/video/pause_icon_x952_y696.png' />"+
			"<image path='assets/gui/video/play_icon_x952_y696.png' />"+
			"</assets>"
		
		);
		private static var  _loadedAssets:Vector.<Asset>;
		
		private var _totalAssets:uint=0;
		
		public function AssetsManager(){
			complete = new Signal();
			_loadedAssets = new Vector.<Asset>();
			preloadAssets();
		}
		
		private function preloadAssets():void{
			for each(var image:XML in _assets.children()){
				loadAsset(image.@path);
				_totalAssets++;
			}
		}
		
		public static function getAssetByName(name:String):DisplayObject{
			var displayObj:DisplayObject;
			for each(var obj:Asset in _loadedAssets){
				if(obj.name == name){
					displayObj  = new Bitmap(Bitmap(obj.image).bitmapData.clone());//clone
					break;	
				}
			}
			return displayObj;
		}
		
		public static function getBitmapData(name:String):BitmapData{
			var displayObj:BitmapData;
			for each(var obj:Asset in _loadedAssets){
				if(obj.name == name){
					displayObj  =Bitmap(obj.image).bitmapData;
					break;	
				}
			}
			return displayObj;
			
		}
		
		public static function getBitmap(name:String,clone:Boolean=false):Bitmap{
			var displayObj:Bitmap;
			for each(var obj:Asset in _loadedAssets){
				if(obj.name == name){
					if(clone){
						displayObj = new Bitmap(Bitmap(obj.image).bitmapData.clone());//clone
					}else{
						displayObj  =Bitmap(obj.image);
					}
					break;	
				}
			}
			return displayObj;
			
		}
		
		private function onAssetLoaded(e:Event):void{
			_loadedAssets.push(new Asset(LoaderInfo(e.target).url,LoaderInfo(e.target).content));
			if(_totalAssets == _loadedAssets.length){
				//dispatchEvent(new Event(Event.COMPLETE));
				
				complete.dispatch();
			}
		}
		
		private function loadAsset(file:String):void{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			var request:URLRequest = new URLRequest(file);
			loader.load(request);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Unable to load file:(asset manager) "+event.text );
		}
	}


}