class PackingCategory {
  final String id;
  final String name;
  final String icon;
  final String description;

  const PackingCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}

const List<PackingCategory> packingCategories = [
  PackingCategory(id: "baby_kids", name: "Baby & Kids", icon: "🍼", description: "Ex: Diapers, Toys, Baby Wipes"),
  PackingCategory(id: "beach_gear", name: "Beach Gear", icon: "🏖️", description: "Ex: Towel, Sunscreen, Umbrella"),
  PackingCategory(id: "clothing", name: "Clothing", icon: "👕", description: "Ex: T-Shirts, Pants, Underwear"),
  PackingCategory(id: "cold_weather", name: "Cold Weather Gear", icon: "🧤", description: "Ex: Gloves, Beanie, Thermal"),
  PackingCategory(id: "documents", name: "Documents", icon: "📄", description: "Ex: Passport, Visa, ID Card"),
  PackingCategory(id: "electronics", name: "Electronics", icon: "🔌", description: "Ex: Charger, Power Bank, Adapter"),
  PackingCategory(id: "essentials", name: "Essentials", icon: "🎒", description: "Ex: Wallet, Keys, Sunglasses"),
  PackingCategory(id: "food_cooking", name: "Food & Cooking", icon: "🍽️", description: "Ex: Snacks, Stove, Utensils"),
  PackingCategory(id: "laundry", name: "Laundry & Cleaning", icon: "🧺", description: "Ex: Detergent, Bag, Hanger"),
  PackingCategory(id: "medicine", name: "Medicine & Health", icon: "💊", description: "Ex: Pills, First Aid, Thermometer"),
  PackingCategory(id: "entertainment", name: "Mental Health & Entertainment", icon: "🧠", description: "Ex: Journal, Cards, Music"),
  PackingCategory(id: "optional", name: "Optional Items", icon: "🎲", description: "Ex: Decorations, Gifts, Extras"),
  PackingCategory(id: "outdoor", name: "Outdoor / Adventure", icon: "🏕️", description: "Ex: Compass, Binoculars, Map"),
  PackingCategory(id: "packing_gear", name: "Packing Gear", icon: "🧳", description: "Ex: Packing Cubes, Compression Bags"),
  PackingCategory(id: "pets", name: "Pet Travel", icon: "🐾", description: "Ex: Leash, Food Bowl, Carrier"),
  PackingCategory(id: "security", name: "Security & Safety", icon: "🛡️", description: "Ex: Locks, Whistle, Flashlight"),
  PackingCategory(id: "toiletries", name: "Toiletries", icon: "🧼", description: "Ex: Toothbrush, Soap, Towel"),
  PackingCategory(id: "wellness", name: "Wellness & Comfort", icon: "🧘", description: "Ex: Neck Pillow, Lotion, Eye Mask"),
  PackingCategory(id: "work", name: "Work & Productivity", icon: "💼", description: "Ex: Laptop, Notebook, Pen"),
  PackingCategory(id: "jewelry", name: "Jewelry & Accessories", icon: "💍", description: "Ex: Necklace, Watch, Ring"),
  PackingCategory(id: "sports", name: "Sports Equipment", icon: "⚽", description: "Ex: Ball, Jersey, Gear"),
  PackingCategory(id: "formal", name: "Formal Wear", icon: "👔", description: "Ex: Suit, Dress Shoes, Tie"),
  PackingCategory(id: "swimwear", name: "Swimwear", icon: "🩱", description: "Ex: Swimsuit, Goggles, Cap"),
  PackingCategory(id: "shoes", name: "Shoes & Footwear", icon: "👟", description: "Ex: Sneakers, Sandals, Boots"),
  PackingCategory(id: "books", name: "Books & Reading", icon: "📚", description: "Ex: Novels, E-reader, Magazines"),
  PackingCategory(id: "hiking", name: "Hiking Gear", icon: "🥾", description: "Ex: Boots, Poles, Hydration Pack"),
  PackingCategory(id: "camping", name: "Camping Equipment", icon: "⛺", description: "Ex: Tent, Sleeping Bag, Mat"),
  PackingCategory(id: "photography", name: "Photography Gear", icon: "📷", description: "Ex: Camera, Tripod, Lens"),
  PackingCategory(id: "tools", name: "Tools & Repair", icon: "🛠️", description: "Ex: Screwdriver, Tape, Multi-tool"),
];
