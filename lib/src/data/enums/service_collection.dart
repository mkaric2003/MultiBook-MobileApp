enum ServiceCollection {
  wellnessSpa('wellness_spa', 'Wellness & spa'),
  beautyGrooming('beauty_grooming', 'Beauty & grooming'),
  homeRepairs('home_repairs', 'Home repairs'),
  autoServices('auto_services', 'Auto services'),
  healthCare('health_care', 'Health & care'),
  learnGrow('learn_grow', 'Learn & grow'),
  petCare('pet_care', 'Pet care'),
  professionalServices('professional_services', 'Professional services');

  const ServiceCollection(this.id, this.label);

  final String id;
  final String label;
}
