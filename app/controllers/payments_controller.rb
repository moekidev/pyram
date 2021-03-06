class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
    payment = Payment.create(
      book_id: current_book.id,
      date: payment_param[:date],
      tag_id: payment_param[:tag_id],
      memo: payment_param[:memo],
      monthly: payment_param[:monthly]
    )
    Expense.create(
      book_id: current_book.id,
      payment_id: payment.id,
      amount: payment_param[:required],
      type_id: Type.find_by(slug: 'required').id
    )
    Expense.create(
      book_id: current_book.id,
      payment_id: payment.id,
      amount: payment_param[:affluent],
      type_id: Type.find_by(slug: 'affluent').id
    )
    redirect_to book_path(current_book)
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    redirect_to book_path(current_book)
  end

  def update
    @payment = Payment.find(params[:id])
    @payment.update(
      date: payment_param[:date],
      tag_id: payment_param[:tag_id],
      memo: payment_param[:memo],
      monthly: payment_param[:monthly]
    )
    @payment.required_expense.update(amount: payment_param[:required])
    @payment.affluent_expense.update(amount: payment_param[:affluent])
    flash[:notice] = '支出の内容を変更しました😎'
    redirect_to book_path(current_book)
  end

  private
  def payment_param
    params.require(:payment).permit(:amount, :required, :affluent, :date, :monthly, :type_id, :tag_id, :memo)
  end
end
