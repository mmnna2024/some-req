import { mount } from '@vue/test-utils'
import Form from '../Form.vue'

describe('Form', () => {
  it('should render a form', () => {
    const wrapper = mount(Form);
    const comp = wrapper.findComponent(Form);
    expect(comp.exists()).toBe(true);
  });

  it("data test", () => {
    const wrapper = mount(Form);
    expect(wrapper.vm.validation.nameResult).toBe("");
    expect(wrapper.vm.validation.addressResult).toBe("");
  });

  it("name validation test", async () => {
    const wrapper = mount(Form);
    await wrapper.setData({ customer: { name: "" }});
    await wrapper.vm.checkValidate();
    expect(wrapper.vm.validation.nameResult).toBe("名前は入力必須項目です。!!!!");
  });

  // it('should render a submit button', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('button[type="submit"]').length).toEqual(1);
  // });

  // it('should render a name input', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('input[name="name"]').length).toEqual(1);
  // });

  // it('should render a email input', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('input[name="email"]').length).toEqual(1);
  // });

  // it('should render a address input', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('input[name="address"]').length).toEqual(1);
  // });

  // it('should render a phone input', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('input[name="phone"]').length).toEqual(1);
  // });

  // it('should render a credit card input', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('input[name="credit_card"]').length).toEqual(1);
  // });

  // it('should render a expiration date input', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('input[name="expiration_date"]').length).toEqual(1);
  // });

  // it('should render a security code input', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('input[name="security_code"]').length).toEqual(1);
  // });

  // it('should render a submit button', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('button[type="submit"]').length).toEqual(1);
  // });

  // it('should render a reset button', () => {
  //   const wrapper = shallow(<Form />);
  //   expect(wrapper.find('button[type="reset"]').length).toEqual(1);
  // });

  // it('should call handleSubmit when the form is submitted', () => {
  //   const handleSubmit = jest.fn();
  //   const wrapper = shallow(<Form handleSubmit={handleSubmit} />);
  //   wrapper.find('form').simulate('submit', { preventDefault: () => {} });
  //   expect(handleSubmit).toHaveBeenCalled();
  // });
});