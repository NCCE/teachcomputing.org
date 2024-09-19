module StrapiGenerators
  def generate_strapi_content_block
    [{
      type: "paragraph",
      children: [
        {
          text: Faker::Lorem.paragraph,
          type: "text"
        }
      ]
    }]
  end

  def generate_strapi_enrichment_age_group_attributes
    strapi_attributes({
      name: "Key Stage 1"
    })
  end

  def generate_strapi_enrichment_term_attributes
    strapi_attributes({
      name: "Spring"
    })
  end

  def generate_strapi_image_attributes
    strapi_attributes({
      name: "i-belong-camp-0.png",
      alternativeText: "Students and teacher at the Easter I Belong computing camp.",
      caption: "Students and teacher at the Easter I Belong computing camp.",
      width: 630,
      height: 420,
      formats: {
        medium: {
          ext: ".png",
          url: "http://strapi.teachcomputing.test/medium_i_belong_camp_0_99e3e4622a.png",
          hash: "medium_i_belong_camp_0_99e3e4622a",
          mime: "image/png",
          name: "medium_i-belong-camp-0.png",
          size: 390.03,
          width: 500,
          height: 333,
          sizeInBytes: 390028
        },
        small: {
          ext: ".png",
          url: "http://strapi.teachcomputing.test/small_i_belong_camp_0_99e3e4622a.png",
          hash: "small_i_belong_camp_0_99e3e4622a",
          mime: "image/png",
          name: "small_i-belong-camp-0.png",
          size: 390.03,
          width: 500,
          height: 333,
          sizeInBytes: 390028
        },
        thumbnail: {
          ext: ".png",
          url: "http://strapi.teachcomputing.test/thumbnail_i_belong_camp_0_99e3e4622a.png",
          hash: "thumbnail_i_belong_camp_0_99e3e4622a",
          mime: "image/png",
          name: "thumbnail_i-belong-camp-0.png",
          size: 92.52,
          width: 234,
          height: 156,
          sizeInBytes: 92519
        }
      },
      hash: "i_belong_camp_0_99e3e4622a",
      ext: ".png",
      mime: "image/png",
      size: 137.23,
      url: "http://strapi.teachcomputing.test/i_belong_camp_0_99e3e4622a.png"
    })
  end

  def strapi_attributes(data)
    data[:createdAt] = Faker::Time.backward
    data[:updatedAt] = Faker::Time.backward
    data
  end
end
