class ChatsController < ApplicationController
  include Tubesock::Hijack
  helper :emoji
  layout "chat_layout"

  before_action :check_login

  def index
    @twemoji_list,@twemoji_names = {},{}
    # @twemoji_list["basic"] = ":smile:|:laughing:|:blush:|:smiley:|:relaxed:|:smirk:|:heart_eyes:|:kissing_heart:|:kissing_closed_eyes:|:flushed:|:relieved:|:satisfied:|:grin:|:wink:|:stuck_out_tongue_winking_eye:|:stuck_out_tongue_closed_eyes:|:grinning:|:kissing:|:kissing_smiling_eyes:|:stuck_out_tongue:|:sleeping:|:worried:|:frowning:|:anguished:|:open_mouth:|:grimacing:|:confused:|:hushed:|:expressionless:|:unamused:|:sweat_smile:|:sweat:|:weary:|:pensive:|:disappointed:|:confounded:|:fearful:|:cold_sweat:|:persevere:|:cry:|:sob:|:joy:|:astonished:|:scream:|:tired_face:|:angry:|:rage:|:triumph:|:sleepy:|:yum:|:mask:|:sunglasses:|:dizzy_face:|:imp:|:smiling_imp:|:neutral_face:|:no_mouth:|:innocent:"
    # @twemoji_list["extra"] = ":alien:|:yellow_heart:|:blue_heart:|:purple_heart:|:heart:|:green_heart:|:broken_heart:|:heartbeat:|:heartpulse:|:two_hearts:|:revolving_hearts:|:cupid:|:sparkling_heart:|:sparkles:|:star:|:star2:|:dizzy:|:boom:|:anger:|:exclamation:|:question:|:grey_exclamation:|:grey_question:|:zzz:|:dash:|:sweat_drops:|:notes:|:musical_note:|:fire:|:poop:|:thumbsup:|:thumbsdown:|:ok_hand:|:punch:|:fist:|:v:|:wave:|:hand:|:open_hands:|:point_up:|:point_down:|:point_left:|:point_right:|:raised_hands:|:pray:|:point_up_2:|:clap:|:muscle:|:walking:|:runner:|:couple:|:family:|:two_men_holding_hands:|:two_women_holding_hands:|:dancer:|:dancers:|:ok_woman:|:no_good:|:information_desk_person:|:raised_hand:|:bride_with_veil:|:person_with_pouting_face:|:person_frowning:|:bow:|:couplekiss:|:couple_with_heart:|:massage:|:haircut:|:nail_care:|:boy:|:girl:|:woman:|:man:|:baby:|:older_woman:|:older_man:|:person_with_blond_hair:|:man_with_gua_pi_mao:|:man_with_turban:|:construction_worker:|:cop:|:angel:|:princess:|:smiley_cat:|:smile_cat:|:heart_eyes_cat:|:kissing_cat:|:smirk_cat:|:scream_cat:|:crying_cat_face:|:joy_cat:|:pouting_cat:|:japanese_ogre:|:japanese_goblin:|:see_no_evil:|:hear_no_evil:|:speak_no_evil:|:guardsman:|:skull:|:feet:|:lips:|:kiss:|:droplet:|:ear:|:eyes:|:nose:|:tongue:|:love_letter:|:bust_in_silhouette:|:busts_in_silhouette:|:speech_balloon:|:thought_balloon:|:sunny:|:umbrella:|:cloud:|:snowflake:|:snowman:|:zap:|:cyclone:|:foggy:|:ocean:|:cat:|:dog:|:mouse:|:hamster:|:rabbit:|:wolf:|:frog:|:tiger:|:koala:|:bear:|:pig:|:pig_nose:|:cow:|:boar:|:monkey_face:|:monkey:|:horse:|:racehorse:|:camel:|:sheep:|:elephant:|:panda_face:|:snake:|:bird:|:baby_chick:|:hatched_chick:|:hatching_chick:|:chicken:|:penguin:|:turtle:|:bug:|:honeybee:|:ant:|:beetle:|:snail:|:octopus:|:tropical_fish:|:fish:|:whale:|:whale2:|:dolphin:|:cow2:|:ram:|:rat:|:water_buffalo:|:tiger2:|:rabbit2:|:dragon:|:goat:|:rooster:|:dog2:|:pig2:|:mouse2:|:ox:|:dragon_face:|:blowfish:|:crocodile:|:dromedary_camel:|:leopard:|:cat2:|:poodle:|:paw_prints:|:bouquet:|:cherry_blossom:|:tulip:|:four_leaf_clover:|:rose:|:sunflower:|:hibiscus:|:maple_leaf:|:leaves:|:fallen_leaf:|:herb:|:mushroom:|:cactus:|:palm_tree:|:evergreen_tree:|:deciduous_tree:|:chestnut:|:seedling:|:blossom:|:ear_of_rice:|:shell:|:globe_with_meridians:|:sun_with_face:|:full_moon_with_face:|:new_moon_with_face:|:new_moon:|:waxing_crescent_moon:|:first_quarter_moon:|:waxing_gibbous_moon:|:full_moon:|:waning_gibbous_moon:|:last_quarter_moon:|:waning_crescent_moon:|:last_quarter_moon_with_face:|:first_quarter_moon_with_face:|:moon:|:earth_africa:|:earth_americas:|:earth_asia:|:volcano:|:milky_way:|:partly_sunny:|:bamboo:|:gift_heart:|:dolls:|:school_satchel:|:mortar_board:|:flags:|:fireworks:|:sparkler:|:wind_chime:|:rice_scene:|:jack_o_lantern:|:ghost:|:santa:|:8ball:|:alarm_clock:|:apple:|:art:|:baby_bottle:|:balloon:|:banana:|:bar_chart:|:baseball:|:basketball:|:bath:|:bathtub:|:battery:|:beer:|:beers:|:bell:|:bento:|:bicyclist:|:bikini:|:birthday:|:black_joker:|:black_nib:|:blue_book:|:bomb:|:bookmark:|:bookmark_tabs:|:books:|:boot:|:bowling:|:bread:|:briefcase:|:bulb:|:cake:|:calendar:|:calling:|:camera:|:candy:|:card_index:|:cd:|:chart_with_downwards_trend:|:chart_with_upwards_trend:|:cherries:|:chocolate_bar:|:christmas_tree:|:clapper:|:clipboard:|:closed_book:|:closed_lock_with_key:|:closed_umbrella:|:clubs:|:cocktail:|:coffee:|:computer:|:confetti_ball:|:cookie:|:corn:|:credit_card:|:crown:|:crystal_ball:|:curry:|:custard:|:dango:|:dart:|:date:|:diamonds:|:dollar:|:door:|:doughnut:|:dress:|:dvd:|:e_mail:|:egg:|:eggplant:|:electric_plug:|:email:|:euro:|:eyeglasses:|:fax:|:file_folder:|:fish_cake:|:fishing_pole_and_fish:|:flashlight:|:floppy_disk:|:flower_playing_cards:|:football:|:fork_and_knife:|:fried_shrimp:|:fries:|:game_die:|:gem:|:gift:|:golf:|:grapes:|:green_apple:|:green_book:|:guitar:|:gun:|:hamburger:|:hammer:|:handbag:|:headphones:|:hearts:|:high_brightness:|:high_heel:|:hocho:|:honey_pot:|:horse_racing:|:hourglass:|:hourglass_flowing_sand:|:ice_cream:|:icecream:|:inbox_tray:|:incoming_envelope:|:iphone:|:jeans:|:key:|:kimono:|:ledger:|:lemon:|:lipstick:|:lock:|:lock_with_ink_pen:|:lollipop:|:loop:|:loudspeaker:|:low_brightness:|:mag:|:mag_right:|:mahjong:|:mailbox:|:mailbox_closed:|:mailbox_with_mail:|:mailbox_with_no_mail:|:mans_shoe:|:meat_on_bone:|:mega:|:melon:|:memo:|:microphone:|:microscope:|:minidisc:|:money_with_wings:|:moneybag:|:mountain_bicyclist:|:movie_camera:|:musical_keyboard:|:musical_score:|:mute:|:name_badge:|:necktie:|:newspaper:|:no_bell:|:notebook:|:notebook_with_decorative_cover:|:nut_and_bolt:|:oden:|:open_file_folder:|:orange_book:|:outbox_tray:|:page_facing_up:|:page_with_curl:|:pager:|:paperclip:|:peach:|:pear:|:pencil2:|:phone:|:pill:|:pineapple:|:pizza:|:postal_horn:|:postbox:|:pouch:|:poultry_leg:|:pound:|:purse:|:pushpin:|:radio:|:ramen:|:ribbon:|:rice:|:rice_ball:|:rice_cracker:|:ring:|:rugby_football:|:running_shirt_with_sash:|:sake:|:sandal:|:satellite:|:saxophone:|:scissors:|:scroll:|:seat:|:shaved_ice:|:shirt:|:shower:|:ski:|:smoking:|:snowboarder:|:soccer:|:sound:|:space_invader:|:spades:|:spaghetti:|:speaker:|:stew:|:straight_ruler:|:strawberry:|:surfer:|:sushi:|:sweet_potato:|:swimmer:|:syringe:|:tada:|:tanabata_tree:|:tangerine:|:tea:|:telephone_receiver:|:telescope:|:tennis:|:toilet:|:tomato:|:tophat:|:triangular_ruler:|:trophy:|:tropical_drink:|:trumpet:|:tv:|:unlock:|:vhs:|:video_camera:|:video_game:|:violin:|:watch:|:watermelon:|:wine_glass:|:womans_clothes:|:womans_hat:|:wrench:|:yen:|:aerial_tramway:|:airplane:|:ambulance:|:anchor:|:articulated_lorry:|:atm:|:bank:|:barber:|:beginner:|:bike:|:blue_car:|:boat:|:bridge_at_night:|:bullettrain_front:|:bullettrain_side:|:bus:|:busstop:|:car:|:carousel_horse:|:checkered_flag:|:church:|:circus_tent:|:city_sunrise:|:city_sunset:|:construction:|:convenience_store:|:crossed_flags:|:department_store:|:european_castle:|:european_post_office:|:factory:|:ferris_wheel:|:fire_engine:|:fountain:|:fuelpump:|:helicopter:|:hospital:|:hotel:|:hotsprings:|:house:|:house_with_garden:|:japan:|:japanese_castle:|:light_rail:|:love_hotel:|:minibus:|:monorail:|:mount_fuji:|:mountain_cableway:|:mountain_railway:|:moyai:|:office:|:oncoming_automobile:|:oncoming_bus:|:oncoming_police_car:|:oncoming_taxi:|:performing_arts:|:police_car:|:post_office:|:railway_car:|:rainbow:|:rocket:|:roller_coaster:|:rotating_light:|:round_pushpin:|:rowboat:|:school:|:ship:|:slot_machine:|:speedboat:|:stars:|:station:|:statue_of_liberty:|:steam_locomotive:|:sunrise:|:sunrise_over_mountains:|:suspension_railway:|:taxi:|:tent:|:ticket:|:tokyo_tower:|:tractor:|:traffic_light:|:train2:|:tram:|:triangular_flag_on_post:|:trolleybus:|:truck:|:vertical_traffic_light:|:warning:|:wedding:|:jp:|:kr:|:cn:|:us:|:fr:|:es:|:it:|:ru:|:gb:|:de:|:100:|:1234:|:a:|:ab:|:abc:|:abcd:|:accept:|:aquarius:|:aries:|:arrow_backward:|:arrow_double_down:|:arrow_double_up:|:arrow_down:|:arrow_down_small:|:arrow_forward:|:arrow_heading_down:|:arrow_heading_up:|:arrow_left:|:arrow_lower_left:|:arrow_lower_right:|:arrow_right:|:arrow_right_hook:|:arrow_up:|:arrow_up_down:|:arrow_up_small:|:arrow_upper_left:|:arrow_upper_right:|:arrows_clockwise:|:arrows_counterclockwise:|:b:|:baby_symbol:|:baggage_claim:|:ballot_box_with_check:|:bangbang:|:black_circle:|:black_square_button:|:cancer:|:capital_abcd:|:capricorn:|:chart:|:children_crossing:|:cinema:|:cl:|:clock1:|:clock10:|:clock1030:|:clock11:|:clock1130:|:clock12:|:clock1230:|:clock130:|:clock2:|:clock230:|:clock3:|:clock330:|:clock4:|:clock430:|:clock5:|:clock530:|:clock6:|:clock630:|:clock7:|:clock730:|:clock8:|:clock830:|:clock9:|:clock930:|:congratulations:|:cool:|:copyright:|:curly_loop:|:currency_exchange:|:customs:|:diamond_shape_with_a_dot_inside:|:do_not_litter:|:eight:|:eight_pointed_black_star:|:eight_spoked_asterisk:|:end:|:fast_forward:|:five:|:four:|:free:|:gemini:|:hash:|:heart_decoration:|:heavy_check_mark:|:heavy_division_sign:|:heavy_dollar_sign:|:heavy_minus_sign:|:heavy_multiplication_x:|:heavy_plus_sign:|:id:|:ideograph_advantage:|:information_source:|:interrobang:|:keycap_ten:|:koko:|:large_blue_circle:|:large_blue_diamond:|:large_orange_diamond:|:left_luggage:|:left_right_arrow:|:leftwards_arrow_with_hook:|:leo:|:libra:|:link:|:m:|:mens:|:metro:|:mobile_phone_off:|:negative_squared_cross_mark:|:new:|:ng:|:nine:|:no_bicycles:|:no_entry:|:no_entry_sign:|:no_mobile_phones:|:no_pedestrians:|:no_smoking:|:non_potable_water:|:o:|:o2:|:ok:|:on:|:one:|:ophiuchus:|:parking:|:part_alternation_mark:|:passport_control:|:pisces:|:potable_water:|:put_litter_in_its_place:|:radio_button:|:recycle:|:red_circle:|:registered:|:repeat:|:repeat_one:|:restroom:|:rewind:|:sa:|:sagittarius:|:scorpius:|:secret:|:seven:|:signal_strength:|:six:|:six_pointed_star:|:small_blue_diamond:|:small_orange_diamond:|:small_red_triangle:|:small_red_triangle_down:|:soon:|:sos:|:symbols:|:taurus:|:three:|:tm:|:top:|:trident:|:twisted_rightwards_arrows:|:two:|:u5272:|:u5408:|:u55b6:|:u6307:|:u6708:|:u6709:|:u6e80:|:u7121:|:u7533:|:u7981:|:u7a7a:|:underage:|:up:|:vibration_mode:|:virgo:|:vs:|:wavy_dash:|:wc:|:wheelchair:|:white_check_mark:|:white_circle:|:white_flower:|:white_square_button:|:womens:|:x:|:zero:"
    # @twemoji_list.each do |k,v|
    #   @twemoji_list[k] = Twemoji.parse(v).split("|")
    #   @twemoji_names[k] = v.gsub(":","").split("|")
    # end
  end

  def chat
    puts "params #{params}"

    if params[:user_id].present?
      hijack do |tubesock|
        # Listen on its own thread
        puts "hijack started"
        redis_thread = Thread.new do
          puts "\n\n new thread created \n\n"

          @@redis = Redis.new
          @@redis.hset("users", current_user.id.to_s, current_user.user_name)

          # Needs its own redis connection to pub
          # and sub at the same time
          @@redis.subscribe "chat-#{params[:user_id]}" do |on|
            puts "Subscribe to Redis channel"
            on.message do |channel, message|
              puts "Message to be sent #{message}"
              tubesock.send_data message
            end
          end
        end

        tubesock.onmessage do |params|
          puts "onmessage #{params}"
          @@redis = Redis.new
          # pub the message when we get one
          # note: this echoes through the sub above
          params = JSON.parse(params)

          sender_name = @@redis.hmget("users",params["sender_id"]) rescue User.where(id: params["sender_id"]).first.user_name
          recipient_name = @@redis.hmget("users",params["recipient_id"]) rescue User.where(id: params["recipient_id"]).first.user_name

          if recipient_name.present? && sender_name.present?
            params['sender_name'] = sender_name
            params['recipient_name'] = recipient_name

            # use emojify here
            params["message"] = Twemoji.parse(params["message"])

            puts "onmessage final #{params}"

            @@redis.publish "chat-#{params['sender_id']}", params.to_json
            @@redis.publish "chat-#{params['recipient_id']}", params.to_json
          else
            raise StandardError, "Invalid Sender id #{params['sender_id']} or Recipient id #{params['recipient_id']}"
          end
        end

        tubesock.onclose do
          puts "onclose"

          @@redis = Redis.new
          @@redis.hdel("users",current_user.id.to_s)

          # stop listening when client leaves
          redis_thread.kill
        end
      end
    end
  end

  def send_message
    errors = []
    if params[:message].present?
      message = Twemoji.parse(params[:message])
    else
      errors << ["Message not present"]
    end

    if params[:recipient_id].present?
      recipient = User.where(id: params[:recipient_id]).first
    else
      errors << ["Recipient not present"]
    end

    respond_to do |format|
		  if errors.blank?
        publish_message(current_user, recipient,message)
        format.html { redirect_to :back }
        format.json { render json: {message: 'yay'} }
      else
        format.html { redirect_to :back }
        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
	end

  private

  def publish_message(sender, recipient, message)
    channels = [get_private_channel(recipient.id.to_s), get_private_channel(sender.id.to_s)]

    channels.each do |channel|
      PrivatePub.publish_to(channel,
        sender_id: sender.id,
        sender_name: sender.user_name,
        recipient_id: recipient.id,
        recipient_name: recipient.name,
        message: message
      )
    end
  end

  def get_private_channel(user_id)
    "/chats/#{user_id}"
  end

  def get_public_channel
    "/chats/public"
  end
end