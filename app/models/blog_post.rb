class BlogPost < ApplicationRecord
  has_one_attached :cover_image
  has_rich_text :content

  validates :cover_image, presence: true

  # scope :filter_by_kit, ->(kit) { where kit: kit }

  # enum kit: ["Miscellaneous", "Empennage", "Wing", "Fuselage", "Finishing", "Firewall Forward"]
  # enum section: ["ONE", "TWO", "THREE", "FOUR", "FIVE", "VERTICAL_STABILIZER", "RUDDER", "HORIZONTAL_STABILIZER", "ELEVATORS", "TAILCONE", "EMPENNAGE_ATTACH", "EMPENNAGE_FAIRINGS", "MAIN_SPAR", "WING_RIBS", "REAR_SPAR", "TOP_WING_SKINS", "OUTBOARD_LEADING_EDGE", "FUEL_TANK", "STALL_WARNING_SYSTEM", "BOTTOM_WING_SKINS", "AILERON", "FLAP", "AILERON_ACTUATION", "WING_TIP", "MID_FUSE_BULKHEADS", "MID_FUSE_RIBS_&_BOTTOM_SKINS", "FIREWALL", "FWD_FUSE_RIBS, BHDS_&_BOTTOM_SKIN", "FUSE_SIDE_SKINS", "STEP_INSTALLATION", "UPPER_FORWARD_FUSELAGE_ASSEMBLY", "TAILCONE_ATTACHMENT", "BAGGAGE_AREA", "BAGGAGE_DOOR", "ACCESS_COVERS_AND_FLOOR_PANELS", "BRAKE_LINES", "FUEL_SYSTEM", "RUDDER_PEDALS_&_BRAKE_SYSTEM", "CONTROL_SYSTEM", "FLAP_SYSTEM", "UPPER_FORWARD_FUSELAGE_INSTALLATION", "REAR_SEAT_BACKS", "CABIN_COVER", "WING_ATTACHMENT", "CABIN_DOORS_&_TRANSPARENCIES", "ENGINE_MOUNT_&_LANDING_GEAR", "SPINNER_&_COWLING", "GEAR_LEG_&_WHEEL_FAIRINGS", "SEATS_&_SEATBELTS", "CABIN_HEAT_&_VENTILATION"]

  def self.ransackable_attributes(auth_object = nil)
    ["completed", "created_at", "duration", "id", "id_value", "kit", "section", "title", "updated_at"]
  end
end
