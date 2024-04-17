import { nameValidate } from "../validator";

describe("nameValidate", () => {
  it("should return an error message when the name is empty", () => {
    expect(nameValidate("")).toEqual({ message: "名前は入力必須項目です。!!!!" });
  });

  it("should return an empty message when the name is not empty", () => {
    expect(nameValidate("test")).toEqual({ message: "" });
  });
})