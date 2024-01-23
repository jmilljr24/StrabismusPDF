class BlogPost < ApplicationRecord
  has_rich_text :content

  scope :filter_by_kit, ->(kit) { where kit: kit }

  enum kit: ["Miscellaneous", "Empennage", "Wing", "Fuselage", "Finishing", "Firewall Forward"]
  enum section: ["ONE", "TWO", "THREE", "FOUR", "FIVE", "VERTICAL
  STABILIZER", "RUDDER", "HORIZONTAL STABILIZER", "ELEVATORS", "TAILCONE", "EMPENNAGE ATTACH", "EMPENNAGE
  FAIRINGS", "MAIN SPAR", "WING RIBS", "REAR SPAR", "TOP WING SKINS", "OUTBOARD
  LEADING EDGE", "FUEL TANK", "STALL WARNING
  SYSTEM", "BOTTOM
  WING SKINS", "AILERON", "FLAP", "AILERON ACTUATION", "WING TIP", "MID FUSE
  BULKHEADS", "MID FUSE
  RIBS &
  BOTTOM
  SKINS", "FIREWALL", "FWD FUSE RIBS, BHDS
  & BOTTOM SKIN", "FUSE
  SIDE SKINS", "STEP INSTALLATION", "UPPER FORWARD FUSELAGE
  ASSEMBLY", "TAILCONE
  ATTACHMENT", "BAGGAGE
  AREA", "BAGGAGE
  DOOR", "ACCESS COVERS
  AND FLOOR PANELS", "BRAKE LINES", "FUEL SYSTEM", "RUDDER PEDALS & BRAKE SYSTEM", "CONTROL
  SYSTEM", "FLAP SYSTEM", "UPPER FORWARD FUSELAGE INSTALLATION", "REAR SEAT BACKS", "CABIN COVER", "WING ATTACHMENT", "CABIN DOORS & TRANSPARENCIES", "ENGINE
  MOUNT &
  LANDING
  GEAR", "SPINNER
  & COWLING", "GEAR LEG
  & WHEEL
  FAIRINGS", "SEATS & SEATBELTS", "CABIN HEAT & VENTILATION"]

  def self.ransackable_attributes(auth_object = nil)
    ["completed", "created_at", "duration", "id", "id_value", "kit", "section", "title", "updated_at"]
  end
end
