class PackagePhotographer {
  int? id;
  int? packageId;
  int? subPackageId;
  int? photographerId;
  int? additionalCharge;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? photographerName;
  String? photographerImage;

  PackagePhotographer(
      {this.id,
      this.packageId,
      this.subPackageId,
      this.photographerId,
      this.additionalCharge,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.photographerName,
      this.photographerImage});

  PackagePhotographer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    subPackageId = json['sub_package_id'];
    photographerId = json['photographer_id'];
    additionalCharge = json['additional_charge'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    photographerName = json['photographer_name'];
    photographerImage = json['photographer_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_id'] = this.packageId;
    data['sub_package_id'] = this.subPackageId;
    data['photographer_id'] = this.photographerId;
    data['additional_charge'] = this.additionalCharge;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['photographer_name'] = this.photographerName;
    data['photographer_image'] = this.photographerImage;
    return data;
  }
}
